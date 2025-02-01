local lspconfig = require'lspconfig'
-- cmp_nvim_lspのcapabilitiesを作成
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- LSPサーバーの設定
-- (ここではpyrightを例とする)
lspconfig.pyright.setup{}
-- PHP (Intelephense) の設定
lspconfig.intelephense.setup{
    capabilities = capabilities
}
-- Vue.js (Volar) の設定
lspconfig.volar.setup{
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
}
-- Terraform (Terraform Language Server) の設定
lspconfig.terraformls.setup{}
-- Shell (Bash Language Server) の設定
lspconfig.bashls.setup{}
-- Docker (Dockerfile Language Server) の設定
lspconfig.dockerls.setup{}
-- YAML (YAML Language Server) の設定
lspconfig.yamlls.setup{}
-- JSON (JSON Language Server) の設定
lspconfig.jsonls.setup{}
-- HTML (HTML Language Server) の設定
lspconfig.html.setup{}
-- CSS (CSS Language Server) の設定
lspconfig.cssls.setup{}
-- SCSS (Sass Language Server) の設定
lspconfig.sqlls.setup{}
-- SQL (SQL Language Server) の設定
lspconfig.sqls.setup{}
-- lua (lua Language Server) の設定
lspconfig.lua_ls.setup{
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
