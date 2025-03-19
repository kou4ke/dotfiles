require('mason-lspconfig').setup({
    ensure_installed = {
        "pyright",
        "intelephense",
        "volar",
        "typescript-language-server",
        "terraformls",
        "bashls",
        "dockerls",
        "yamlls",
        "jsonls",
        "html",
        "cssls",
        "stylelint_lsp",
        "tailwindcss",
        -- "sqls",
        "lua_ls",
        -- "eslint_d",
        -- "prettier"
    },
})
