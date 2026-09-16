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

-- Vue (Vue Language Server) の設定
-- nvim-lspconfig で volar は vue_ls に改名され、volar という名前は 3.0.0 で削除される。
-- 旧設定は cmd = { "vls" }（Vetur の言語サーバー）を volar（Volar/Vue LS）の定義に載せていて
-- 実体と定義が食い違っていた。Vetur は新形式（lsp/*.lua）に vuels の定義が無く
-- vim.lsp.enable() では使えないため、mason 導入済みの vue-language-server に寄せる。
local mason_vue_ls = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server"

vim.lsp.config('vue_ls', {
    -- Vue LS 2.x は initializationOptions.typescript.tsdk が必須で、無いと initialize が
    -- "Cannot read properties of undefined (reading 'typescript')" で失敗する。
    -- 既定値は mason 同梱の typescript（5.7 系）。
    init_options = {
        typescript = { tsdk = mason_vue_ls .. "/node_modules/typescript/lib" },
    },
    -- プロジェクトが自前の typescript を持っていればそちらを使う。
    -- mason 同梱版とプロジェクト側でバージョンが食い違うと型解決の結果がズレるため。
    before_init = function(_, config)
        if not config.root_dir then
            return
        end

        local tsdk = config.root_dir .. "/node_modules/typescript/lib"
        if vim.uv.fs_stat(tsdk) then
            config.init_options.typescript.tsdk = tsdk
        end
    end,
})

-- TypeScript / JavaScript (typescript-language-server) の設定
-- Vue LS 2.x は hybrid mode で動作し .vue のテンプレートとスタイルだけを担当する。
-- .vue 内の TypeScript は ts_ls に @vue/typescript-plugin を読ませて担当させる。
-- プラグインは vue-language-server パッケージの依存として同梱されている。
vim.lsp.config('ts_ls', {
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
        'vue',
    },
    init_options = {
        plugins = {
            {
                name = '@vue/typescript-plugin',
                location = mason_vue_ls
                    .. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
                languages = { 'vue' },
            },
        },
    },
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
-- cmd は指定しない。旧設定の "vscode-json-languageserver" は npm グローバル（nodenv 配下）に
-- 入っている旧名パッケージを掴んでいて、node のバージョンを切り替えると解決できなくなる。
-- 既定の "vscode-json-language-server" なら mason 管理（ensure_installed の json-lsp）が使われる。
vim.lsp.config('jsonls', {
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
    'vue_ls',
    'ts_ls',
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
