-- cmp_nvim_lspのcapabilitiesを作成
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local schemastore = require('schemastore')
local lsp_diagnostic = require("config.lsp-diagnostic")

-- グローバル設定 (全LSPサーバーに適用)
vim.lsp.config('*', {
    capabilities = capabilities,
    on_attach = lsp_diagnostic.on_attach,
})

-- LSPサーバーの設定
-- Python (Pyright) の設定
vim.lsp.config('pyright', {})

-- PHP (Intelephense) の設定
vim.lsp.config('intelephense', {
    cmd = { "intelephense", "--stdio" },
    filetypes = { "php" },
    settings = {
        intelephense = {
            environment = {
                includePaths = { "vendor/laravel/framework/src", "vendor" }
            },
            files = {
                maxSize = 5000000,
                exclude = { "**/storage/**", "**/bootstrap/cache/**" }
            },
            stubs = { "laravel", "eloquent", "blade" }
        }
    },
})

-- volar (Volar Language Server) の設定
vim.lsp.config('volar', {
    cmd = { "vls" },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
})

-- Terraform (Terraform Language Server) の設定
vim.lsp.config('terraformls', {
    filetypes = { 'terraform' },
})

-- Shell (Bash Language Server) の設定
vim.lsp.config('bashls', {})

-- Docker (Dockerfile Language Server) の設定
vim.lsp.config('dockerls', {})

-- docker-compose (Docker Compose Language Server) の設定
vim.lsp.config('docker_compose_language_service', {
    cmd = { "docker-compose-language-service", "--stdio" },
    filetypes = { "docker-compose" },
    settings = {
        dockerCompose = {
            filetypes = { "docker-compose" },
        },
    },
})

-- YAML (YAML Language Server) の設定
vim.lsp.config('yamlls', {})

-- JSON (JSON Language Server) の設定
vim.lsp.config('jsonls', {
    cmd = { "vscode-json-languageserver", "--stdio" },
    settings = {
        json = {
            schemas = schemastore.json.schemas(),
            validate = { enable = true }
        },
    },
})

-- HTML (HTML Language Server) の設定
vim.lsp.config('html', {
    filetypes = { "html" },
})

-- CSS (CSS Language Server) の設定
vim.lsp.config('cssls', {
    filetypes = { "css" },
})

-- Tailwind CSS の設定
vim.lsp.config('tailwindcss', {
    cmd = { "npx", "tailwindcss-language-server", "--stdio" },
    filetypes = { "html", "css", "scss", "sass", "javascript", "javascriptreact", "typescript", "typescriptreact" },
})

-- Vim (Vim Language Server) の設定
vim.lsp.config('vimls', {
    cmd = { "vim-language-server", "--stdio" },
    filetypes = { "vim" },
})

-- lua (lua Language Server) の設定
vim.lsp.config('lua_ls', {
    filetypes = { "lua" },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

-- LSPサーバーを有効化
vim.lsp.enable({
    'pyright',
    'intelephense',
    'volar',
    'terraformls',
    'bashls',
    'dockerls',
    'docker_compose_language_service',
    'yamlls',
    'jsonls',
    'html',
    'cssls',
    'tailwindcss',
    'vimls',
    'lua_ls',
})
