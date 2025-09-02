local wezterm = require 'wezterm'

return {
  color_scheme = "Wombat",
  selection_word_boundary = ",│`|:\"' ()[]{}<>\t",
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
      event = { Down = { streak = 1, button = "Left" } },
      mods = "SHIFT",
      action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
    },
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
}
