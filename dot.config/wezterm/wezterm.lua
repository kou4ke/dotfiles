local wezterm = require 'wezterm'
local act = wezterm.action

return {
  color_scheme = "Wombat",
  selection_word_boundary = ",│`|:\"' ()[]{}<>\t",
  use_ime = true,
  keys = {
    {key="Enter", mods="ALT", action=wezterm.action.ToggleFullScreen},
  },
  mouse_bindings = {
    {
      event = { Down = { streak = 1, button = "Right" } },
      mods = "SHIFT",
      action = wezterm.action.PasteFrom("Clipboard"),
    },
    {
      event = { Drag = { streak = 1, button = "Left" } },
      mods = "SHIFT",
      action = wezterm.action_callback(function(window, pane)
        local selection = window:get_selection_text_for_pane(pane)
        if selection and #selection >= 2 then
          window:perform_action(wezterm.action.CopyTo("ClipboardAndPrimarySelection"), pane)
        end
      end),
    },
    -- Bind 'Up' event of CTRL-Click to open hyperlinks
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
    },
    -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
    {
      event = { Down = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.Nop,
    }
  },
  default_prog = { "wsl.exe" },
  font_size = 11,
  font = wezterm.font_with_fallback {
    { family = "PlemolJP Console NF", weight = "Regular" },
  },
  font_rules = {
    {
      italic = false,
      intensity = "Bold",
      font = wezterm.font("PlemolJP Console NF", { weight = "Bold" }),
    },
    {
      italic = true,
      intensity = "Normal",
      font = wezterm.font("PlemolJP Console NF", { italic = true }),
    },
    {
      italic = true,
      intensity = "Bold",
      font = wezterm.font("PlemolJP Console NF", { weight = "Bold", italic = true }),
    },
  },
  -- window_decorations = "RESIZE|TITLE|MENU|MINIMIZE|MAXIMIZE|CLOSE",
  window_background_opacity = 0.85,

  hide_tab_bar_if_only_one_tab = true,
}
