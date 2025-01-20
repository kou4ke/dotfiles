 require("ibl").setup({

  indent = {

    char = "│",
  },
  scope = {
    enabled = true,
    show_start = true,
    show_end = true,
    injected_languages = true,
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
