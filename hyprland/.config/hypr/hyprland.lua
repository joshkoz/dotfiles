-- Hyprland Lua config
-- https://wiki.hypr.land/Configuring/Start/

local colors = require("mocha")

local terminal = "ghostty"
local menu = "vicinae toggle"
local mainMod = "SUPER"

----------------
-- MONITORS ---
----------------

hl.monitor({ output = "DP-1", mode = "highres", position = "auto-left", scale = 1.67 })
hl.monitor({ output = "DP-2", mode = "highres", position = "auto-right", scale = 1.67 })

-----------------
-- AUTOSTART ---
-----------------

hl.on("hyprland.start", function()
  hl.exec_cmd("dbus-update-activation-environment --systemd --all")
  hl.exec_cmd("hyprctl setcursor Adwaita 18")
  hl.exec_cmd('tmux setenv -g HYPRLAND_INSTANCE_SIGNATURE "$HYPRLAND_INSTANCE_SIGNATURE"')
  hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 18")
  hl.dispatch(hl.dsp.focus({ monitor = "DP-2" }))
end)

-------------------------------
-- ENVIRONMENT VARIABLES ---
-------------------------------

hl.env("XCURSOR_SIZE", "18")
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("HYPRCURSOR_SIZE", "18")
hl.env("HYPRCURSOR_THEME", "Adwaita")

-- Nvidia specific
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- Toolkit-specific scale
hl.env("TERMINAL", "ghostty")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("GDK_SCALE", "1.5")
hl.env("GTK_THEME", "catppuccin-mocha-peach-standard+default")

hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Prevent double scaling of Qt apps
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "0")
hl.env("QT_ENABLE_HIGHDPI_SCALING", "0")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-----------------------
-- LOOK AND FEEL ---
-----------------------

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    col = {
      active_border = { colors = { colors.peach, colors.maroon }, angle = 45 },
      inactive_border = colors.base,
    },
    resize_on_border = true,
    allow_tearing = false,
    layout = "dwindle",
  },

  decoration = {
    rounding = 0,
    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      color = "rgba(1a1a1aee)",
      range = 4,
      enabled = true,
      render_power = 3,
    },

    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      popups = true,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },

  dwindle = {
    preserve_split = true,
  },

  master = {
    new_status = "master",
  },

  input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_options = "",
    kb_rules = "",

    follow_mouse = 1,
    float_switch_override_focus = 0,
    mouse_refocus = false,
    sensitivity = -0.5,

    touchpad = {
      natural_scroll = false,
    },
  },

  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
    on_focus_under_fullscreen = 2,
    focus_on_activate = true,
  },

  xwayland = {
    force_zero_scaling = true,
  },

  cursor = {
    default_monitor = "DP-2",
    no_warps = false,
    sync_gsettings_theme = false,
  },
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = false, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = false, speed = 1, bezier = "default", style = "fade" })

---------------------
-- KEYBINDINGS ---
---------------------

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("wlogout"))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- Move focus with mainMod + h/j/k/l
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Switch workspaces with mainMod + QWERTYUIOP
hl.bind(mainMod .. " + Q", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + W", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + E", function()
  hl.dispatch(hl.dsp.focus({ workspace = 3 }))
  hl.dispatch(hl.dsp.focus({ monitor = "DP-1" }))
end)
hl.bind(mainMod .. " + R", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + T", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + Y", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + U", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + I", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + O", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + P", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + [0-9]
hl.bind(mainMod .. " + 1", hl.dsp.window.move({ workspace = 1, follow = false }))
hl.bind(mainMod .. " + 2", hl.dsp.window.move({ workspace = 2, follow = false }))
hl.bind(mainMod .. " + 3", hl.dsp.window.move({ workspace = 3, follow = false }))
hl.bind(mainMod .. " + 4", hl.dsp.window.move({ workspace = 4, follow = false }))
hl.bind(mainMod .. " + 5", hl.dsp.window.move({ workspace = 5, follow = false }))
hl.bind(mainMod .. " + 6", hl.dsp.window.move({ workspace = 6, follow = false }))
hl.bind(mainMod .. " + 7", hl.dsp.window.move({ workspace = 7, follow = false }))
hl.bind(mainMod .. " + 8", hl.dsp.window.move({ workspace = 8, follow = false }))
hl.bind(mainMod .. " + 9", hl.dsp.window.move({ workspace = 9, follow = false }))
hl.bind(mainMod .. " + 0", hl.dsp.window.move({ workspace = 10, follow = false }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + CTRL + L", hl.dsp.workspace.move({ monitor = "+1" }))
hl.bind(mainMod .. " + CTRL + H", hl.dsp.workspace.move({ monitor = "-1" }))
hl.bind("CTRL + SHIFT + S", hl.dsp.exec_cmd("screenshot.sh area"))
hl.bind("CTRL + SHIFT + A", hl.dsp.exec_cmd("/home/joshua/.bin/pick-output-audio.sh"))
hl.bind("CTRL + SHIFT + M", hl.dsp.exec_cmd("/home/joshua/.bin/pick-input-audio.sh"))
hl.bind("CTRL + SHIFT + D", hl.dsp.exec_cmd("hyprpicker --autocopy"))

hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("/home/joshua/.bin/set-wallpaper.sh"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("/home/joshua/.bin/hyprlock-wrapper.sh --no-fade-in"))

-- Multimedia controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("volume-change.sh up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("volume-change.sh down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

-- Media player controls
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-------------------
-- WORKSPACES ---
-------------------

-- Monitor DP-1 (Secondary/Side)
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
hl.workspace_rule({ workspace = "10", monitor = "DP-1" })

-- Monitor DP-2 (Primary)
hl.workspace_rule({ workspace = "1", monitor = "DP-2" })
hl.workspace_rule({ workspace = "2", monitor = "DP-2" })
hl.workspace_rule({ workspace = "4", monitor = "DP-2" })
hl.workspace_rule({ workspace = "5", monitor = "DP-2" })
hl.workspace_rule({ workspace = "6", monitor = "DP-2", default = true })
hl.workspace_rule({ workspace = "7", monitor = "DP-2" })
hl.workspace_rule({ workspace = "8", monitor = "DP-2" })
hl.workspace_rule({ workspace = "9", monitor = "DP-2" })

---------------------
-- WINDOW RULES ---
---------------------

require("rules")

--------------
-- DEVICES ---
--------------

hl.device({
  name = "wacom-one-by-wacom-s-pen",
  output = "DP-2",
})
