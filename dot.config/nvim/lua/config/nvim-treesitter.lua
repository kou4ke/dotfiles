require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "bash", "terraform", "php" },
    ignore_install = { "sh" },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  })
