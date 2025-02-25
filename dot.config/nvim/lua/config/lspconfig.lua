local lspconfig = require'lspconfig'
-- cmp_nvim_lspのcapabilitiesを作成
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
local schemastore = require('schemastore')

-- LSPサーバーの設定
-- (ここではpyrightを例とする)
lspconfig.pyright.setup{
    capabilities = capabilities
}
-- PHP (Intelephense) の設定
lspconfig.intelephense.setup{
    cmd = { "intelephense", "--stdio" },
    filetypes = { "php" },
    settings = {
        intelephense = {
            files = {
                maxSize = 1000000;
            };
        };
    },
    capabilities = capabilities,
}
-- Vue.js (Volar) の設定
lspconfig.volar.setup{
    cmd = { "vls" },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
    capabilities = capabilities
}
-- Terraform (Terraform Language Server) の設定
lspconfig.terraformls.setup{
    filetypes = { 'terraform' },
    capabilities = capabilities
}
-- Shell (Bash Language Server) の設定
lspconfig.bashls.setup{
    capabilities = capabilities
}
-- Docker (Dockerfile Language Server) の設定
lspconfig.dockerls.setup{
    capabilities = capabilities
}
-- YAML (YAML Language Server) の設定
lspconfig.yamlls.setup{
    capabilities = capabilities
}
-- JSON (JSON Language Server) の設定
lspconfig.jsonls.setup{
    cmd = { "vscode-json-languageserver", "--stdio" },
    settings = {
        json = {
            schemas = schemastore.json.schemas(),
            validate = { enable = true }
        },
    },
    capabilities = capabilities,
}
-- HTML (HTML Language Server) の設定
lspconfig.html.setup{
    filetypes = { "html" },
    capabilities = capabilities
}
-- CSS (CSS Language Server) の設定
lspconfig.cssls.setup{
    filetypes = { "css" },
    capabilities = capabilities
}
-- SCSS (Sass Language Server) の設定
--
lspconfig.tailwindcss.setup{
    cmd = { "npx", "tailwindcss-language-server", "--stdio" },
    filetypes = { "html", "css", "scss", "sass", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    capabilities = capabilities,
}
-- SQL (SQL Language Server) の設定
-- lspconfig.sqls.setup{
--     cmd = { "sqls" },
--     filetypes = { "sql" },
--     settings = {
--       -- sqls = {
--       --   connections = {
--       --     {
--       --       driver = 'mysql',
--       --       dataSourceName = 'user:password@tcp(127.0.0.1:3306)/dbname',
--       --     },
--       --   },
--       -- },
--     },
--     capabilities = capabilities
-- }
-- lua (lua Language Server) の設定
lspconfig.lua_ls.setup{
    filetypes = { "lua" },
    settings = {
        Lua = {
            runtime = {
              -- Luaのバージョン（通常はLuaJITを使用）
              version = 'LuaJIT',
            },
            diagnostics = {
              -- グローバル変数の認識を追加する
              globals = { 'vim' },
            },
            workspace = {
              -- LuaランタイムファイルをLSPに通知
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
        },
    },
    capabilities = capabilities
}
