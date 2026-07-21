-- =====================================================================
-- WINDOW RULES — traducao das 18 "bspc rule" do bspwmrc
--
-- Sintaxe nova do 0.55.4 (o formato "windowrule = float, class:..." morreu):
--   hl.window_rule({ name = "...", match = { class = "..." }, float = true })
--
-- Mapa bspwm -> Lua:
--   desktop='^8'        -> workspace = "8"
--   follow=off          -> workspace = "8 silent"
--   state=floating      -> float = true
--   state=fullscreen    -> fullscreen = true
--   rectangle=LxA+X+Y   -> size = "L A"  +  move = "X Y"
--   layer=above         -> pin = true
--   center=true         -> center = true
--   ignore_ewmh_focus   -> no_focus = true   (NAO "nofocus" — invalido)
--
-- ATENCAO: no bspwm as regras casam por WM_CLASS (X11). Confirme cada uma:
--   hyprctl clients | grep -E 'class|title'
-- =====================================================================

local R = hl.window_rule

-- vlc: state=fullscreen
R({ name = "vlc-fs", match = { class = "^(vlc)$" }, fullscreen = true })

-- xfreerdp: desktop=8, floating, follow=on, center
R({ name = "xfreerdp", match = { class = "^(xfreerdp)$" },
    workspace = "8", float = true, center = true })

-- rdesktop: desktop=8, monocle, follow=on, center
-- [~] state=monocle nao existe por-janela; usando maximize
R({ name = "rdesktop", match = { class = "^(rdesktop)$" },
    workspace = "8", maximize = true })

-- gnome-calculator: floating, rectangle=0x0+1550+60, follow=on
R({ name = "calc", match = { class = "^(gnome-calculator)$" },
    float = true, move = "1550 60" })

-- Remmina: desktop=7, monocle, follow=on
R({ name = "remmina", match = { class = "^(org\\.remmina\\.Remmina)$" },
    workspace = "7", maximize = true })

-- Bashtop / Ranger: floating, follow=on
R({ name = "bashtop", match = { class = "^(Bashtop)$" }, float = true })
R({ name = "ranger",  match = { class = "^(Ranger)$"  }, float = true })

-- Calendar: floating, rectangle=680x770+540+110, layer=above
R({ name = "calendar", match = { class = "^(Calendar)$" },
    float = true, size = "680 770", move = "540 110", pin = true })

-- Fzfsearch: idem
R({ name = "fzfsearch", match = { class = "^(Fzfsearch)$" },
    float = true, size = "680 770", move = "540 110", pin = true })

-- Marcacao: floating, rectangle=980x770+540+110, layer=above, center
R({ name = "marcacao", match = { class = "^(Marcacao)$" },
    float = true, size = "980 770", center = true, pin = true })

-- Zathura: floating, rectangle=980x1020+540+40, layer=above
R({ name = "zathura", match = { class = "^(org\\.pwmt\\.zathura)$" },
    float = true, size = "980 1020", move = "540 40", pin = true })

-- Zoiper5: desktop=7, floating, follow=off
-- Aqui mora o hack do ignore_ewmh_focus: no_focus impede o roubo de foco
R({ name = "zoiper", match = { class = "^(Zoiper5)$" },
    workspace = "7 silent", float = true, no_focus = true })

-- obs: desktop=7, follow=off
R({ name = "obs", match = { class = "^(com\\.obsproject\\.Studio)$" },
    workspace = "7 silent" })

-- IRPF: floating, follow=on
R({ name = "irpf", match = { class = "^(serpro-ppgd-app-IRPFPGD)$" }, float = true })

-- Sxiv: floating (considere trocar por imv, nativo Wayland)
R({ name = "sxiv", match = { class = "^(Sxiv)$" }, float = true })

-- Vpn: desktop=8, monocle, follow=off
R({ name = "vpn", match = { class = "^(Vpn)$" },
    workspace = "8 silent", maximize = true })

-- Kittyfloat: floating, rectangle=680x770+540+110, follow=on
R({ name = "kittyfloat", match = { class = "^(Kittyfloat)$" },
    float = true, size = "680 770", move = "540 110" })

-- =====================================================================
-- Extras uteis que o bspwm nao tinha
-- =====================================================================
R({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })
R({ name = "idle-fs",           match = { class = ".*" }, idle_inhibit = "fullscreen" })

R({ name = "pavucontrol", match = { class = "^(pavucontrol)$" },        float = true })
R({ name = "nm-editor",   match = { class = "^(nm-connection-editor)$" }, float = true })
R({ name = "blueman",     match = { class = "^(blueman-manager)$" },    float = true })

-- Picture-in-Picture do navegador
R({ name = "pip", match = { title = "^(Picture-in-Picture)$" }, float = true, pin = true })

-- Corrige arrasto de janelas XWayland (recomendacao do exemplo oficial)
R({ name = "fix-xwayland-drags",
    match = { class = "^$", title = "^$", xwayland = true },
    no_focus = true })
