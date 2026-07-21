-- =====================================================================
-- BINDS — traducao do ~/.dotfiles/dotfiles/.config/sxhkd/sxhkdrc
-- Marcadores:  [=] equivalente exato   [~] parcial   [X] sem equivalente
-- =====================================================================

local mod  = "SUPER"
local term = "kitty"
local dsp  = hl.dsp
local home = os.getenv("HOME")
local scr  = home .. "/.config/hypr-jp/scripts"

-- ---------------------------------------------------------------------
-- wm independent hotkeys
-- ---------------------------------------------------------------------
hl.bind(mod .. " + Return", dsp.exec_cmd(term))                                    -- [=]
hl.bind(mod .. " + space",  dsp.exec_cmd("rofi -modi drun,run -show drun -show-icons")) -- [=]

-- quit/restart  (era: bspc quit / bspc wm -r)
hl.bind(mod .. " + ALT + Q", dsp.exit())                                           -- [=] sai direto

-- Menu de sessao. NAO existia no sxhkdrc (no bspwm voce saia pelo polybar),
-- e sem ele nao ha como deslogar pelo teclado. Mesma tecla da ML4W.
hl.bind(mod .. " + CTRL + Q", dsp.exec_cmd("wlogout"))

-- close and kill
hl.bind(mod .. " + W",           dsp.window.close())                               -- [=] bspc node -c
hl.bind(mod .. " + SHIFT + W",   dsp.window.kill())                                -- [=] bspc node -k
hl.bind("ALT + W",               dsp.window.close())                               -- [=]
hl.bind("ALT + SHIFT + W",       dsp.window.kill())                                -- [=]

-- monocle
hl.bind(mod .. " + M", dsp.window.fullscreen({ mode = "maximized" }))               -- [~]

-- send the newest marked node to the newest preselected node
hl.bind(mod .. " + Y", dsp.layout("movetoroot"))                                   -- [~]

-- [X] bspc node -s biggest — dwindle nao tem "biggest"

-- ---------------------------------------------------------------------
-- state/flags   super + {t,shift+t,s,f}
-- ---------------------------------------------------------------------
hl.bind(mod .. " + T",         dsp.window.float({ action = "disable" }))           -- [=] tiled
hl.bind(mod .. " + SHIFT + T", dsp.window.pseudo())                                -- [=] pseudo_tiled
hl.bind(mod .. " + S",         dsp.window.float({ action = "enable" }))            -- [=] floating
hl.bind(mod .. " + F",         dsp.window.fullscreen())                            -- [=] fullscreen

hl.bind(mod .. " + CTRL + Y",  dsp.window.pin())                                   -- [=] sticky
-- [X] marked / locked / private — sem equivalente

-- ---------------------------------------------------------------------
-- focus / swap  (vim keys)
-- ---------------------------------------------------------------------
local dirs = { H = "left", J = "down", K = "up", L = "right" }
for key, dir in pairs(dirs) do
    hl.bind(mod .. " + " .. key,           dsp.focus({ direction = dir }))         -- [=]
    hl.bind(mod .. " + SHIFT + " .. key,   dsp.window.swap({ direction = dir }))   -- [=]
end

-- [X] super + {p,b,comma,period} (parent/brother/first/second)
--     dwindle nao expoe navegacao na arvore. O plugin hy3 entrega isso.

-- focus next/prev node
hl.bind(mod .. " + C",         dsp.window.cycle_next())                            -- [=]
hl.bind(mod .. " + SHIFT + C", dsp.window.cycle_next({ prev = true }))
hl.bind("ALT + C",             dsp.window.cycle_next())
hl.bind("ALT + SHIFT + C",     dsp.window.cycle_next({ prev = true }))

-- focus next/prev desktop
hl.bind(mod .. " + bracketleft",  dsp.focus({ workspace = "e-1" }))                -- [=]
hl.bind(mod .. " + bracketright", dsp.focus({ workspace = "e+1" }))

-- focus last node
hl.bind(mod .. " + Tab", dsp.focus({ window = "last" }))                           -- [=]

-- focus older/newer (aproximacao)
hl.bind(mod .. " + O", dsp.window.cycle_next({ prev = true }))                     -- [~]
hl.bind(mod .. " + I", dsp.window.cycle_next())                                    -- [~]

-- ---------------------------------------------------------------------
-- preselect — dwindle SUPORTA (a grande vitoria sobre o niri)
-- ---------------------------------------------------------------------
hl.bind(mod .. " + CTRL + H", dsp.layout("preselect l"))                           -- [=]
hl.bind(mod .. " + CTRL + J", dsp.layout("preselect d"))
hl.bind(mod .. " + CTRL + K", dsp.layout("preselect u"))
hl.bind(mod .. " + CTRL + L", dsp.layout("preselect r"))
hl.bind(mod .. " + CTRL + space", dsp.layout("preselect none"))                    -- [=] cancel

-- preselect ratio (super+ctrl+{1-9})
-- [~] nao ha ratio de preselect; splitratio ajusta o split do no atual
for i = 1, 9 do
    hl.bind(mod .. " + CTRL + " .. i, dsp.layout("splitratio exact 0." .. i))
end

-- ---------------------------------------------------------------------
-- move / resize
-- ---------------------------------------------------------------------
local rez = {
    { "H", -20,  0 }, { "J", 0,  20 }, { "K", 0, -20 }, { "L",  20, 0 },
}
for _, r in ipairs(rez) do
    hl.bind(mod .. " + ALT + " .. r[1],
            dsp.window.resize({ x = r[2], y = r[3] }), { repeating = true })       -- [=] expand
    hl.bind(mod .. " + ALT + SHIFT + " .. r[1],
            dsp.window.resize({ x = -r[2], y = -r[3] }), { repeating = true })     -- [=] contract
end

-- move a floating window (super + setas)
local mv = { left = {-40, 0}, down = {0, 40}, up = {0, -40}, right = {40, 0} }
for key, d in pairs(mv) do
    hl.bind(mod .. " + " .. key, dsp.window.move({ x = d[1], y = d[2] }),
            { repeating = true })                                                  -- [=]
end

-- bspwm pointer_modifier mod1 + pointer_action{1,2,3}
hl.bind("ALT + mouse:272", dsp.window.drag(),   { drag = true })                   -- [=] botao esq
hl.bind("ALT + mouse:273", dsp.window.resize(), { drag = true })                   -- [=] botao dir

-- ---------------------------------------------------------------------
-- SUBMAP "apps"  <- super + x; {b,r,c,v,o,p,m,k}
-- O chord do sxhkd. No Lua fica mais limpo: uma funcao, saida automatica.
-- ---------------------------------------------------------------------
local apps = {
    B = "kitty --class Bashtop  -e bashtop",
    R = "kitty --class Ranger   -e ranger",
    C = "kitty -c " .. home .. "/.config/kitty/gruvbox_light.conf --class Calendar -e testecal",
    V = "kitty --class Vim      -e vim",
    O = "kitty -c " .. home .. "/.config/kitty/gruvbox_light.conf --class Fzfsearch -e fzfsearch",
    P = "kitty --class Vpn      -e tmux-vpn-sonicwall.sh",
    M = "kitty --class Marcacao -o font_size=15 -e consulta_marcacao.sh",
    K = "kitty --class Kittyfloat",
}
hl.define_submap("apps", function()
    for key, cmd in pairs(apps) do
        hl.bind(key, function()
            hl.dispatch(dsp.exec_cmd(cmd))
            hl.dispatch(dsp.submap("reset"))
        end)
    end
    hl.bind("escape", dsp.submap("reset"))
end)
hl.bind(mod .. " + X", dsp.submap("apps"))

-- ---------------------------------------------------------------------
-- SUBMAP "layout"  <- super + e; {1..9}  (bsp-layout)
-- Dos 9 layouts do bsp-layout, ~7 tem equivalente. grid/rgrid nao tem.
-- ---------------------------------------------------------------------
local layouts = {
    ["1"] = function() hl.config({ general = { layout = "dwindle" } }) end,  -- tiled
    ["3"] = function() hl.config({ general = { layout = "master"  } }) end,  -- even
}
local orient = {
    ["6"] = "orientationright",   -- rtall
    ["7"] = "orientationbottom",  -- rwide
    ["8"] = "orientationleft",    -- tall
    ["9"] = "orientationtop",     -- wide
}
hl.define_submap("layout", function()
    for key, fn in pairs(layouts) do
        hl.bind(key, function() fn(); hl.dispatch(dsp.submap("reset")) end)
    end
    hl.bind("2", function()
        hl.dispatch(dsp.window.fullscreen({ mode = "maximized" }))                  -- monocle
        hl.dispatch(dsp.submap("reset"))
    end)
    for key, msg in pairs(orient) do
        hl.bind(key, function()
            hl.dispatch(dsp.layout(msg))
            hl.dispatch(dsp.submap("reset"))
        end)
    end
    -- [X] 4 = grid / 5 = rgrid — sem equivalente
    hl.bind("escape", dsp.submap("reset"))
end)
hl.bind(mod .. " + E", dsp.submap("layout"))

-- super + {Next,Prior} -> bsp-layout next/previous
hl.bind(mod .. " + Next",  dsp.layout("orientationnext"))                          -- [~]
hl.bind(mod .. " + Prior", dsp.layout("orientationprev"))

-- ---------------------------------------------------------------------
-- WORKSPACES
-- ---------------------------------------------------------------------
for i = 1, 10 do
    local key = i % 10                                        -- 10 -> tecla 0
    hl.bind(mod .. " + " .. key,               dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. key,       dsp.window.move({ workspace = i, silent = true }))
    hl.bind("ALT + " .. key,                   dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + ALT + " .. key, dsp.window.move({ workspace = i }))  -- follow
end

-- send to monitor
hl.bind(mod .. " + SHIFT + equal", dsp.window.move({ monitor = "+1" }))            -- [=]

-- ---------------------------------------------------------------------
-- Minhas customizacoes (parte final do sxhkdrc)
-- ---------------------------------------------------------------------
hl.bind("ALT + SHIFT + X", dsp.exec_cmd("hyprlock"))                               -- [=] betterlockscreen
hl.bind("ALT + SHIFT + C", dsp.dpms("off"))                                        -- [=] xset dpms

-- screenshot (era: flameshot gui)
hl.bind("Print",           dsp.exec_cmd("grimblast --notify copysave area"))       -- [=]
hl.bind("SHIFT + Print",   dsp.exec_cmd("grimblast --notify copysave screen"))

-- [X] super+shift+e / super+shift+b — dwindle nao rebalanceia a arvore

hl.bind(mod .. " + SHIFT + R", dsp.layout("togglesplit"))                          -- [~] rotate
-- [X] super+alt+r (flip 180) — sem equivalente

hl.bind(mod .. " + SHIFT + D", dsp.layout("rollnext"))                             -- [~] circulate
hl.bind(mod .. " + SHIFT + A", dsp.layout("rollprev"))

-- gaps dinamicos — em runtime, direto no Lua (sem script externo)
local gaps = 2
local function set_gaps(delta)
    gaps = math.max(0, math.min(60, gaps + delta))
    hl.config({ general = { gaps_in = gaps, gaps_out = gaps * 2 } })
end
hl.bind(mod .. " + ALT + bracketleft",  function() set_gaps(-5) end)               -- [=]
hl.bind(mod .. " + ALT + bracketright", function() set_gaps(5) end)

-- rofi
hl.bind(mod .. " + ALT + space",   dsp.exec_cmd("rofi -show window"))              -- [=]
hl.bind(mod .. " + SHIFT + space", dsp.exec_cmd(home .. "/bin/rofi-remote-desktops.sh")) -- [=]

-- hide / unhide  (era: ~/bin/winhide)
hl.bind(mod .. " + SHIFT + I", dsp.window.move({ workspace = "special:hidden", silent = true }))
hl.bind("ALT + I",             dsp.workspace.toggle_special("hidden"))
hl.bind(mod .. " + D",         dsp.exec_cmd(scr .. "/hide-all.sh"))                -- [=] oculta todas

-- monocle padding p/ ultrawide (era: super+n)
hl.bind(mod .. " + N", dsp.exec_cmd(scr .. "/ultrawide.sh"))                       -- [=]

-- reload
hl.bind(mod .. " + Escape",  dsp.exec_cmd("hyprctl reload"))
hl.bind(mod .. " + ALT + R", dsp.exec_cmd("hyprctl reload"))

-- ---------------------------------------------------------------------
-- Audio / brilho — pamixer, para nao quebrar a memoria muscular
-- ---------------------------------------------------------------------
local media = {
    { "XF86AudioRaiseVolume",  "pamixer -i 5",                     true  },
    { "XF86AudioLowerVolume",  "pamixer -d 5",                     true  },
    { "XF86AudioMute",         "pamixer -t",                       false },
    { "XF86AudioMicMute",      "pamixer --default-source -t",      false },
    { "XF86MonBrightnessUp",   "brightnessctl -q s +10%",          true  },
    { "XF86MonBrightnessDown", "brightnessctl -q s 10%-",          true  },
    { "XF86AudioPlay",         "playerctl play-pause",             false },
    { "XF86AudioNext",         "playerctl next",                   false },
    { "XF86AudioPrev",         "playerctl previous",               false },
}
for _, m in ipairs(media) do
    hl.bind(m[1], dsp.exec_cmd(m[2]), { locked = true, repeating = m[3] })
end

-- xbindkeys: b:9 / b:8 -> volume (botoes laterais do mouse)
hl.bind("mouse:276", dsp.exec_cmd("pamixer -i 5"))                                 -- [=] b:9
hl.bind("mouse:275", dsp.exec_cmd("pamixer -d 5"))                                 -- [=] b:8
