-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 15

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.window_background_opacity = 1

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- and finally, return the configuration to wezterm
return config
