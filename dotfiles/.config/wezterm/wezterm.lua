-- =============================================================================
--
--                  WEZTERM CONFIGURATION by @jpaulo
--
-- =============================================================================
-- https://mwop.net/blog/2024-07-04-how-i-use-wezterm.html

-- Importa as bibliotecas necessárias do WezTerm
local wezterm = require("wezterm")
local mux = wezterm.mux
local action = wezterm.action

-- Cria o objeto de configuração principal
local config = wezterm.config_builder()

-- =============================================================================
-- :: FUNÇÕES AUXILIARES (HELPERS)
-- =============================================================================

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
                -- Se estiver no Neovim, repassa a combinação de teclas
                wezterm.log_info("Neovim detectado: Enviando CTRL-" .. key .. " para o painel")
                win:perform_action({ SendKey = { key = key, mods = "CTRL" } }, pane)
            else
                -- Caso contrário, executa a navegação de painel do WezTerm
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

-- :: Esquema de Cores ::
config.color_scheme = 'Atelier Cave Light (base16)'

local colors = {
    background = '#efecf4',
    foreground = '7e56c2',
    active_bg = '#1e66f5',   -- Azul Escuro
    active_fg = '#1e1e2e',
    inactive_bg = '#6c7086', -- Azul Claro/Acinzentado
    inactive_fg = '#1e1e2e',
}
config.colors = {
    tab_bar = {
        background = colors.background,

        new_tab = {
            bg_color = colors.background,
            fg_color = '#cdd6f4',
        },

        new_tab_hover = {
            bg_color = '#313244',
            fg_color = '#ffffff',
        },
    },
}

-- :: Janela e Decoração ::
config.window_decorations = "RESIZE"
config.window_padding = {
    top = 10,
    bottom = 10,
    left = 10,
    right = 10,
}

-- :: Barra de Abas (Tab Bar) ::
config.use_fancy_tab_bar = false -- Desativa a barra de abas padrão para usar a customizada abaixo
-- config.hide_tab_bar_if_only_one_tab = true

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return tab_info.active_pane.title
end

wezterm.on('update-status', function(window)
    -- Grab the utf8 character for the "powerline" left facing
    -- solid arrow.
    -- local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
    local SOLID_LEFT_ARROW = ''
    -- local SOLID_LEFT_ARROW = 'a'

    -- Grab the current window's configuration, and from it the
    -- palette (this is the combination of your chosen colour scheme
    -- including any overrides).
    local color_scheme = window:effective_config().resolved_palette
    -- local bg = color_scheme.background
    -- local fg = color_scheme.foreground
    local bg = colors.active_bg
    local fg = colors.active_fg


    window:set_right_status(wezterm.format({
        -- First, we draw the arrow...
        { Background = { Color = 'none' } },
        { Foreground = { Color = bg } },
        { Text = SOLID_LEFT_ARROW },
        -- Then we draw our text
        { Background = { Color = bg } },
        { Foreground = { Color = fg } },
        { Text = ' ' .. wezterm.hostname() .. ' ' },
    }))
end)

-- wezterm.on('update-right-status', function(window, pane)
--     local date = wezterm.strftime '%H:%M %Y-%m-%d'

--     -- Make it italic and underlined
--     window:set_right_status(wezterm.format {
--         { Attribute = { Underline = 'Single' } },
--         { Attribute = { Italic = true } },
--         { Text = date },
--     })
-- end)

-- Evento para formatar o título da aba de forma customizada (Powerline style)
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    -- Cores utilizadas para a barra de abas customizada
    local colors = {
        background = '#efecf4',
        active_bg = '#1e66f5',   -- Azul Escuro
        active_fg = '#1e1e2e',
        inactive_bg = '#6c7086', -- Azul Claro/Acinzentado
        inactive_fg = '#1e1e2e',
    }

    -- Caracteres separadores da Nerd Font (Powerline)
    local left_separator = ''
    local right_separator = ''

    -- Pega o título do painel ativo e o trunca se for muito longo
    local title = wezterm.truncate_right(tab_title(tab), max_width)
    --
    -- Número da aba (1-based para ficar mais intuitivo)
    local tab_index = tostring(tab.tab_index + 1)

    if tab.is_active then
        -- Formato para a ABA ATIVA
        return {
            { Background = { Color = colors.background } },
            { Foreground = { Color = colors.active_bg } },
            { Text = left_separator },
            { Background = { Color = colors.active_bg } },
            { Foreground = { Color = colors.active_fg } },
            { Text = ' ' .. tab_index .. ':' .. title .. ' ' },
            { Background = { Color = colors.background } },
            { Foreground = { Color = colors.active_bg } },
            { Text = right_separator },
        }
    else
        -- Formato para as ABAS INATIVAS
        return {
            { Background = { Color = colors.background } },
            { Foreground = { Color = colors.inactive_bg } },
            { Text = left_separator },
            { Background = { Color = colors.inactive_bg } },
            { Foreground = { Color = colors.inactive_fg } },
            { Text = ' ' .. tab_index .. ':' .. title .. ' ' },
            { Background = { Color = colors.background } },
            { Foreground = { Color = colors.inactive_bg } },
            { Text = right_separator },
        }
    end
end)


-- =============================================================================
-- :: COMPORTAMENTO (BEHAVIOR)
-- =============================================================================

-- Inicia novas janelas já maximizadas
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)


-- =============================================================================
-- :: ATALHOS DE TECLADO (KEYBINDINGS)
-- =============================================================================

-- Define a tecla "Leader" (CTRL+a)
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

-- Tabela principal com todos os atalhos
config.keys = {
    -- :: Gerenciamento de Painéis (Panes) ::
    { key = "\\", mods = "LEADER", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "-",  mods = "LEADER", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "m",  mods = "LEADER", action = action.TogglePaneZoomState },

    -- Rename current tab; analagous to command in tmux
    {
        key = ',',
        mods = 'LEADER',
        action = action.PromptInputLine {
            description = 'Enter new name for tab',
            action = wezterm.action_callback(
                function(window, pane, line)
                    if line then
                        window:active_tab():set_title(line)
                    end
                end
            ),
        },
    },

    -- copy mode
    {
        key = '[',
        mods = 'LEADER',
        action = wezterm.action.ActivateCopyMode,
    },

    -- :: Navegação Condicional de Painéis (h,j,k,l) ::
    split_nav("h"),
    split_nav("j"),
    split_nav("k"),
    split_nav("l"),

    -- :: Redimensionamento de Painéis ::
    { key = "h", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Left", 5 }) },
    { key = "l", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Right", 5 }) },
    { key = "j", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Down", 5 }) },
    { key = "k", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Up", 5 }) },

    -- :: Gerenciamento de Abas (Tabs) ::
    { key = "c", mods = "LEADER",     action = action.SpawnTab("CurrentPaneDomain") },
    { key = "p", mods = "LEADER",     action = action.ActivateTabRelative(-1) }, -- Aba anterior
    { key = "n", mods = "LEADER",     action = action.ActivateTabRelative(1) },  -- Próxima aba

    -- :: Modo de Cópia ::
    { key = "[", mods = "LEADER",     action = action.ActivateCopyMode },
}

-- Adiciona atalhos para ativar abas de 1 a 9 (LEADER + número)
for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = action.ActivateTab(i - 1),
    })
end


-- =============================================================================
-- :: RETORNO FINAL DA CONFIGURAÇÃO
-- =============================================================================
return config
