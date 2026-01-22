-- =============================================================================
--
--                  WEZTERM CONFIGURATION by @jpaulo
--
-- =============================================================================
-- Referência: https://mwop.net/blog/2024-07-04-how-i-use-wezterm.html

-- :: Imports ::
local wezterm = require("wezterm")
local mux = wezterm.mux
local action = wezterm.action

-- Cria o objeto de configuração principal
local config = wezterm.config_builder()

-- =============================================================================
-- :: DEFINIÇÕES GLOBAIS & CORES
-- =============================================================================

-- Definição da paleta de cores personalizada para uso na interface (abas, status, etc)
local theme_colors = {
    background  = '#efecf4',
    foreground  = '7e56c2',
    active_bg   = '#1e66f5',   -- Azul Escuro (Aba ativa / Status)
    active_fg   = '#1e1e2e',   -- Texto na aba ativa
    inactive_bg = '#6c7086',   -- Azul Claro/Acinzentado (Aba inativa)
    inactive_fg = '#1e1e2e',   -- Texto na aba inativa
}

-- Configuração de Cores do Terminal
config.color_scheme = 'Atelier Cave Light (base16)'

-- Cores específicas da Barra de Abas (Tab Bar)
config.colors = {
    tab_bar = {
        background = theme_colors.background,
        new_tab = {
            bg_color = theme_colors.background,
            fg_color = '#cdd6f4',
        },
        new_tab_hover = {
            bg_color = '#313244',
            fg_color = '#ffffff',
        },
    },
}

-- =============================================================================
-- :: FUNÇÕES AUXILIARES (HELPERS)
-- =============================================================================

-- Retorna o título sugerido para a aba.
-- Prioriza o título definido manualmente, caso contrário usa o do painel ativo.
local function get_tab_title(tab_info)
    local title = tab_info.tab_title
    if title and #title > 0 then
        return title
    end
    return tab_info.active_pane.title
end

-- Função para navegação condicional de painéis (Vim vs WezTerm).
-- Permite usar CTRL + h/j/k/l para navegar entre painéis do WezTerm,
-- mas repassa as teclas se o Neovim estiver em execução no painel ativo.
local function split_nav(key)
    local direction_map = { h = "Left", j = "Down", k = "Up", l = "Right" }
    local direction = direction_map[key]

    return {
        key = key,
        mods = "CTRL",
        action = wezterm.action_callback(function(win, pane)
            if not pane then return end

            -- Verifica a variável de usuário definida pelo Neovim (`IS_NVIM`)
            if pane:get_user_vars().IS_NVIM == "true" then
                wezterm.log_info("Neovim detectado: Enviando CTRL-" .. key .. " para o painel")
                win:perform_action({ SendKey = { key = key, mods = "CTRL" } }, pane)
            else
                wezterm.log_info("Fora do Neovim: Ativando painel na direção " .. direction)
                win:perform_action({ ActivatePaneDirection = direction }, pane)
            end
        end),
    }
end

-- =============================================================================
-- :: APARÊNCIA (APPEARANCE)
-- =============================================================================

-- :: Fonte e Terminal ::
config.term = "xterm-256color"
config.font_size = 16

-- :: Janela e Decoração ::
config.window_decorations = "RESIZE"
config.window_padding = {
    top = 10,
    bottom = 10,
    left = 10,
    right = 10,
}

-- :: Configuração da Barra de Abas (Customizada) ::
config.use_fancy_tab_bar = false -- Desativa a barra padrão para usar 'format-tab-title'

-- =============================================================================
-- :: EVENTOS E CUSTOMIZAÇÃO DE UI
-- =============================================================================

-- Inicia novas janelas já maximizadas
wezterm.on ("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

-- Formata o status no canto direito da janela (Hostname)
wezterm.on ('update-status', function(window)
    local SOLID_LEFT_ARROW = ''
    local bg = theme_colors.active_bg
    local fg = theme_colors.active_fg

    window:set_right_status(wezterm.format({
        { Background = { Color = 'none' } },
        { Foreground = { Color = bg } },
        { Text = SOLID_LEFT_ARROW },
        { Background = { Color = bg } },
        { Foreground = { Color = fg } },
        { Text = ' ' .. wezterm.hostname() .. ' ' },
    }))
end)

-- Formata o título e estilo das abas (Powerline style)
wezterm.on ('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local left_separator = ''
    local right_separator = ''

    local title = wezterm.truncate_right(get_tab_title(tab), max_width)
    local tab_index = tostring(tab.tab_index + 1) -- 1-based index

    -- Define cores baseadas se a aba está ativa ou inativa
    local bg_color = tab.is_active and theme_colors.active_bg or theme_colors.inactive_bg
    local fg_color = tab.is_active and theme_colors.active_fg or theme_colors.inactive_fg

    return {
        { Background = { Color = theme_colors.background } },
        { Foreground = { Color = bg_color } },
        { Text = left_separator },
        { Background = { Color = bg_color } },
        { Foreground = { Color = fg_color } },
        { Text = ' ' .. tab_index .. ':' .. title .. ' ' },
        { Background = { Color = theme_colors.background } },
        { Foreground = { Color = bg_color } },
        { Text = right_separator },
    }
end)

-- =============================================================================
-- :: ATALHOS DE TECLADO (KEYBINDINGS)
-- =============================================================================

-- Define a tecla "Leader" (CTRL+a)
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
    -- :: Gerenciamento de Painéis (Splits & Zoom) ::
    { key = "\", mods = "LEADER", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "-",  mods = "LEADER", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "m",  mods = "LEADER", action = action.TogglePaneZoomState },

    -- :: Redimensionamento de Painéis (CTRL+SHIFT+hjkl) ::
    { key = "h", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Left", 5 }) },
    { key = "j", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Down", 5 }) },
    { key = "k", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Up", 5 }) },
    { key = "l", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Right", 5 }) },

    -- :: Navegação Smart (Vim/WezTerm) ::
    split_nav("h"),
    split_nav("j"),
    split_nav("k"),
    split_nav("l"),

    -- :: Gerenciamento de Abas ::
    { key = "c", mods = "LEADER", action = action.SpawnTab("CurrentPaneDomain") },
    { key = "p", mods = "LEADER", action = action.ActivateTabRelative(-1) },
    { key = "n", mods = "LEADER", action = action.ActivateTabRelative(1) },

    -- Renomear aba atual (Estilo tmux)
    {
        key = ',',
        mods = 'LEADER',
        action = action.PromptInputLine {
            description = 'Digite o novo nome para a aba:',
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        },
    },

    -- :: Modo de Cópia ::
    { key = "[", mods = "LEADER", action = action.ActivateCopyMode },
}

-- Adiciona atalhos para ir direto para aba 1-9 (LEADER + numero)
for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = action.ActivateTab(i - 1),
    })
end

-- =============================================================================
-- :: FINALIZAÇÃO
-- =============================================================================
return config