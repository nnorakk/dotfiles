-- wezterm.lua configuration

-- Importa as bibliotecas necessárias do WezTerm
local wezterm = require("wezterm")
local mux = wezterm.mux
local action = wezterm.action

-- Inicia novas janelas maximizadas
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

-- Cria o objeto de configuração principal
local config = wezterm.config_builder()

------------------------------------------------------------------
-- :: Aparência ::
------------------------------------------------------------------

config.color_scheme = 'Atelier Cave Light (base16)'
config.term = "xterm-256color"
config.font_size = 16
config.window_decorations = "RESIZE"
config.window_padding = {
    top = 10,
    bottom = 10,
    left = 10,
    right = 10,
}

------------------------------------------------------------------
-- :: Atalhos de Teclado (Keybindings) ::
------------------------------------------------------------------

-- Define a tecla "Leader" (CTRL+a)
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

-- Função auxiliar para navegação condicional de painéis (Vim vs WezTerm).
-- Permite usar CTRL + h/j/k/l para navegar entre painéis do WezTerm,
-- mas repassa as teclas se o Neovim estiver em execução no painel ativo.
local function split_nav(key)
    local direction_map = {
        h = "Left",
        j = "Down",
        k = "Up",
        l = "Right",
    }
    local direction = direction_map[key]

    return {
        key = key,
        mods = "CTRL",
        action = wezterm.action_callback(function(win, pane)
            if not pane then
                return
            end

            -- Verifica a variável de usuário definida pelo Neovim (`IS_NVIM`)
            if pane:get_user_vars().IS_NVIM == "true" then
                -- Se estiver no Neovim, repassa a combinação de teclas
                wezterm.log_info("Neovim detectado: Enviando CTRL-" .. key .. " para o painel")
                win:perform_action({
                    SendKey = { key = key, mods = "CTRL" },
                }, pane)
            else
                -- Caso contrário, executa a navegação de painel do WezTerm
                wezterm.log_info("Fora do Neovim: Ativando painel na direção " .. direction)
                win:perform_action({ ActivatePaneDirection = direction }, pane)
            end
        end),
    }
end

-- Tabela principal com todos os atalhos
config.keys = {
    -- Gerenciamento de Painéis (Panes)
    { key = "\\", mods = "LEADER", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "-",  mods = "LEADER", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "m",  mods = "LEADER", action = action.TogglePaneZoomState },

    -- Navegação Condicional de Painéis (h,j,k,l)
    split_nav("h"),
    split_nav("j"),
    split_nav("k"),
    split_nav("l"),

    -- Redimensionamento de Painéis
    { key = "h", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Left", 5 }) },
    { key = "l", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Right", 5 }) },
    { key = "j", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Down", 5 }) },
    { key = "k", mods = "CTRL|SHIFT", action = action.AdjustPaneSize({ "Up", 5 }) },

    -- Gerenciamento de Abas (Tabs)
    { key = "c", mods = "LEADER",     action = action.SpawnTab("CurrentPaneDomain") },
    { key = "p", mods = "LEADER",     action = action.ActivateTabRelative(-1) }, -- Aba anterior
    { key = "n", mods = "LEADER",     action = action.ActivateTabRelative(1) },  -- Próxima aba

    -- Modo de Cópia
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

------------------------------------------------------------------
-- :: Retorno Final ::
------------------------------------------------------------------
return config
