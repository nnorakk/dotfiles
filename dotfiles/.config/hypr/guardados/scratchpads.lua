-- =====================================================================
-- SCRATCHPADS — substituem o tdrop (X11-puro, nao roda em Wayland)
--
-- No Hyprland isso e nativo via "special workspaces": nao ha processo
-- externo, nao ha xdotool. on_created_empty sobe o app na primeira vez.
-- =====================================================================

local mod  = "SUPER"
local dsp  = hl.dsp
local home = os.getenv("HOME")

-- --- terminal dropdown  <- super + ctrl + Return (era: tdrop -am -w -18 kitty)
hl.workspace_rule({
    workspace        = "special:term",
    on_created_empty = "kitty --class Scratchterm",
})
hl.bind(mod .. " + CTRL + Return", dsp.workspace.toggle_special("term"))
hl.window_rule({ name = "scratchterm", match = { class = "^(Scratchterm)$" },
                 size = "90% 60%", center = true })

-- --- tmux-scratch  <- super + shift + Return
hl.workspace_rule({
    workspace        = "special:scratch",
    on_created_empty = "sh -c '" .. home .. "/bin/tmux-scratch; kitty --class Scratchtmux'",
})
hl.bind(mod .. " + SHIFT + Return", dsp.workspace.toggle_special("scratch"))
hl.window_rule({ name = "scratchtmux", match = { class = "^(Scratchtmux)$" },
                 size = "90% 60%", center = true })

-- --- fechar o tmux-scratch  <- super + shift + Escape
hl.bind(mod .. " + SHIFT + Escape", dsp.exec_cmd(home .. "/bin/stop-tmux-scratch"))

-- --- gaveta de janelas ocultas (substitui ~/bin/winhide)
--     super+shift+I manda pra ca; alt+I traz de volta (ver binds.lua)
hl.workspace_rule({ workspace = "special:hidden" })
