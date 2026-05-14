-- --- Communication (WS 1) ---
hl.window_rule({
  name = "Slack",
  match = { class = "^(Slack|slack)$" },
  workspace = "1",
  tag = "+comm",
})

hl.window_rule({
  name = "Discord",
  match = { class = "^(discord)$" },
  workspace = "1",
  tag = "+comm",
})

-- --- Development & Tools (WS 3, 5, 8, 9) ---
hl.window_rule({
  name = "Obsidian",
  match = { class = "^(obsidian)$" },
  workspace = "3",
  tag = "+dev",
})

hl.window_rule({
  name = "JetBrains Rider",
  match = { class = "^(jetbrains-rider)$" },
  workspace = "8",
  tag = "+dev",
})

hl.window_rule({
  name = "JetBrains DataGrip",
  match = { class = "^(jetbrains-datagrip)$" },
  workspace = "9",
  tag = "+dev",
})

hl.window_rule({
  name = "JetBrains Focus Behavior",
  match = { class = "^(jetbrains-.*)$" },
  focus_on_activate = false,
})

-- --- Terminal & Browsers (WS 6, 7) ---
hl.window_rule({
  name = "Ghostty Terminal",
  match = { class = "^(.*ghostty)$" },
  workspace = "6",
  tag = "+terminal",
})

hl.window_rule({
  name = "Web Browsers",
  match = { class = "^(firefox|google-chrome)$" },
  workspace = "7",
  tag = "+browser",
})

-- --- Media (WS 10) ---
hl.window_rule({
  name = "Spotify",
  match = { class = "^(Spotify|spotify)$" },
  workspace = "10",
  tag = "+media",
})

hl.window_rule({
  name = "RuneLite",
  match = { class = "net-runelite-client-RuneLite" },
  min_size = { 1, 1 },
})

-- --- Floating & Prompts ---
hl.window_rule({
  name = "Gcr Prompter",
  match = { class = "^(Gcr-prompter)$" },
  float = true,
})

-----------------------
-- SPECIAL FIXES ---
-----------------------

-- --- XWayland Video Bridge (Screensharing fix) ---
hl.window_rule({
  name = "XWayland Video Bridge Fix",
  match = { class = "^(xwaylandvideobridge)$" },
  opacity = "0.0 override",
  no_anim = true,
  no_initial_focus = true,
  max_size = { 1, 1 },
  no_blur = true,
})

-------------------
-- LAYER RULES ---
-------------------

hl.layer_rule({
  name = "vicinae_rule",
  match = { namespace = "^(vicinae)$" },
  ignore_alpha = 1,
  no_anim = true,
  blur = true,
})

hl.layer_rule({
  name = "wlogout_blur",
  match = { namespace = "^(logout_dialog)$" },
  blur = true,
})

-- --- Smart Gaps (No gaps when only one window is open) ---
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })

hl.window_rule({
  name = "Single Window Borders (Tiled)",
  match = {
    workspace = "w[tv1]",
    float = false,
  },
  border_size = 1,
  rounding = 0,
})

hl.window_rule({
  name = "Single Window Borders (Fullscreen)",
  match = {
    workspace = "f[1]",
    float = false,
  },
  border_size = 0,
  rounding = 0,
})
-- --- End Smart Gaps (No gaps when only one window is open) ---
