local lspconfig = require'lspconfig'

-- LSPサーバーの設定
-- (ここではpyrightを例とする)
lspconfig.pyright.setup{}
-- PHP (Intelephense) の設定
lspconfig.intelephense.setup{}
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
--
--
--

