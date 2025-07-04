local highlight = {

    "RainbowRed",

    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup({
  indent = {
    char = "|",
    highlight = highlight,
  },
  scope = {
    enabled = true,
    show_start = true,
    show_end = true,
    injected_languages = false,


    include = {

      node_type = {

        ["*"] = {
          "body",
          "class",
          "function",
          "method",
          "block",
          "list_literal",
          "selector",
          "^if",
          "^table",
          "if_statement",
          "while",
          "for",
          "type",
          "var",
          "import",
          "declaration",
          "expression",
          "pattern",
          "primary_expression",
          "statement",
          "switch_body"
        }

      }
    }
  },
  whitespace = {
    remove_blankline_trail = false,
    highlight = "Whitespace",
  },

  exclude = {
    filetypes = {},
    buftypes = {}
  },

})
