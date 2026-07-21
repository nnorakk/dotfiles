-- =====================================================================
-- Hyprland 0.55.4 — configuracao propria em Lua
-- Traduzida de ~/.dotfiles/dotfiles/.config/{bspwm/bspwmrc,sxhkd/sxhkdrc}
--
-- Ponto de entrada real: ~/.config/hypr/hyprland.lua (carregador de 2 linhas)
-- hyprland.lua tem precedencia sobre hyprland.conf — verificado em 2026-07-20.
--
-- API de referencia: /usr/share/hypr/stubs/hl.meta.lua
-- Exemplo oficial:   /usr/share/hypr/hyprland.lua
-- =====================================================================

local term = "kitty"

-- ---------------------------------------------------------------------
-- MONITOR
-- Acer CB242Y = DP-1 @ 1920x1080@74.986
-- ---------------------------------------------------------------------
hl.monitor({
    output   = "DP-1",
    mode     = "1920x1080@74.986",
    position = "0x0",
    scale     = 1,
})
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

-- ---------------------------------------------------------------------
-- VARIAVEIS DE AMBIENTE
-- ---------------------------------------------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- ---------------------------------------------------------------------
-- OPCOES
-- bspwm: window_gap 4 / border_width 4 / split_ratio 0.52
-- top_padding 29 nao e preciso: waybar reserva espaco via layer-shell
-- ---------------------------------------------------------------------
hl.config({
    general = {
        gaps_in     = 2,          -- ~ window_gap 4 (aqui e meia-distancia)
        gaps_out    = 4,
        border_size = 4,
        col = {
            active_border   = "rgba(406ea5ee)",   -- bspwm focused_border_color
            inactive_border = "rgba(4c566aaa)",   -- bspwm normal_border_color
        },
        resize_on_border = true,
        allow_tearing    = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 0,             -- bspwm nao tinha rounding
        blur   = { enabled = false },
        shadow = { enabled = false },
    },

    dwindle = {
        -- "pseudotile" foi REMOVIDO no 0.55.4. O pseudo_tiled do bspwm
        -- sobrevive como dispatcher (SUPER+SHIFT+T) e como window_rule.
        preserve_split = true,
    },

    input = {
        kb_layout  = "us",
        kb_variant = "intl",      -- US-intl: ' vira dead key -> 'e=é ; 'c=ç via ~/.XCompose
        repeat_delay = 500,
        repeat_rate  = 30,
        numlock_by_default = true,
        follow_mouse  = 1,
        mouse_refocus = false,    -- ~ bspwm ignore_ewmh_focus
        sensitivity   = 0,
        touchpad = { natural_scroll = false },
    },

    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        force_default_wallpaper  = 0,
        focus_on_activate        = false,   -- complementa no_focus do Zoiper
    },

    binds = {
        workspace_back_and_forth = true,
        allow_workspace_cycles   = true,
    },

    cursor = {
        inactive_timeout = 3,     -- <- unclutter
    },

    animations = { enabled = true },
})

-- ---------------------------------------------------------------------
-- ANIMACOES
-- ---------------------------------------------------------------------
hl.curve("suave", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.0} } })
hl.animation({ leaf = "windows",    enabled = true, speed = 4, bezier = "suave" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "suave" })
hl.animation({ leaf = "fade",       enabled = true, speed = 4, bezier = "suave" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "suave" })

-- ---------------------------------------------------------------------
-- GESTOS (sintaxe nova do 0.55; "gestures:workspace_swipe" foi removido)
-- ---------------------------------------------------------------------
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- ---------------------------------------------------------------------
-- WORKSPACES  (traduz o bspwmrc: monitor1 -> 1..8 ; monitor2 -> 9,10)
-- Por maquina, detectada pelo hostname (bspwmrc detectava com xrandr):
--   darkstar (estacao): 2 monitores
--     ultrawide LG (DP-2) -> 1..8 ; AOC (DP-3) -> 9,10
--   casa: monitor unico DP-1 -> 1..8
-- Uso desc: (estavel entre reboots) em vez do conector, que pode mudar.
-- ---------------------------------------------------------------------
local function hostname()
    local f = io.open("/etc/hostname")
    if not f then return "" end
    local h = (f:read("*l") or ""):gsub("%s+", "")
    f:close()
    return h
end

if hostname() == "darkstar" then
    local mon_main = "desc:LG Electronics LG ULTRAWIDE 210AZPUFE632"  -- esquerda
    local mon_side = "desc:AOC 24P1W1 GNSM7XA014090"                  -- direita
    for i = 1, 8 do
        hl.workspace_rule({
            workspace  = tostring(i),
            monitor    = mon_main,
            persistent = true,
            default    = (i == 1),
        })
    end
    for _, i in ipairs({ 9, 10 }) do
        hl.workspace_rule({
            workspace  = tostring(i),
            monitor    = mon_side,
            persistent = true,
            default    = (i == 9),
        })
    end
else
    for i = 1, 8 do
        hl.workspace_rule({
            workspace  = tostring(i),
            monitor    = "DP-1",
            persistent = true,
            default    = (i == 1),
        })
    end
end

-- ---------------------------------------------------------------------
-- AUTOSTART  (traduzido do fim do bspwmrc)
-- ---------------------------------------------------------------------
-- Guarda: permite carregar esta config numa instancia ANINHADA (para testes)
-- sem lancar waybar/kitty/daemons na sessao real. Sem isso, cada teste vaza
-- uma arvore inteira de processos orfaos. Use:
--     HYPRJP_NO_AUTOSTART=1 Hyprland -c ~/.config/hypr-jp/init.lua
if os.getenv("HYPRJP_NO_AUTOSTART") ~= "1" then
hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    hl.exec_cmd("waybar -c ~/.config/waybar-jp/config.jsonc -s ~/.config/waybar-jp/style.css")  -- <- polybar
    hl.exec_cmd("swaync")                                     -- <- dunst
    hl.exec_cmd("hypridle")                                   -- <- xidlehook
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr-jp/scripts/wallpaper.sh")  -- <- feh
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("udiskie")
    hl.exec_cmd("sh -c 'pgrep -x dropbox >/dev/null || dropbox'")
    hl.exec_cmd(term)
end)
end  -- fim da guarda HYPRJP_NO_AUTOSTART

-- --- ainda NAO portados do bspwmrc ---
--   conky x3     -> nao fala layer-shell; so sob XWayland, e mal
--   redshift-gtk -> instalar gammastep (nao instalado) ou usar hyprshade
--   picom / xsetroot / unclutter -> desnecessarios (nativo)

-- ---------------------------------------------------------------------
-- MODULOS
-- ---------------------------------------------------------------------
require("binds")
require("rules")
require("scratchpads")
