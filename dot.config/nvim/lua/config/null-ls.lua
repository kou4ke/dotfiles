local null_ls = require("null-ls")
local lsp_diagnostic = require("config.lsp-diagnostic")
local Path = require("plenary.path")

null_ls.setup({
    temp_dir = os.getenv("HOME").."/tmp/.nvim/null-ls",
    sources = {
        -- Lintツールの設定
        null_ls.builtins.diagnostics.eslint_d,  -- 高速なESLint
        -- null_ls.builtins.diagnostics.eslint,  -- 通常のESLint（高速版を使わない場合）
        -- フォーマットツールの設定

        null_ls.builtins.formatting.prettier.with({
            filetypes = {"vue", "javascript", "typescript", "css", "html", "json"}
        }),
        -- Pintフォーマッターの設定
        null_ls.builtins.formatting.pint.with({
            command = "docker",
            args = function(params)
                local relative_path = Path:new(params.bufname):make_relative(vim.loop.cwd())
                return {
                    "compose",
                    "exec",
                    "app",
                    "composer",
                    "fmt",
                    "--",
                    relative_path
                }
            end,
            filetypes = { "php" }
        }),
    },
    on_attach = function(client, bufnr)
        lsp_diagnostic.on_attach(client, bufnr)
        -- フォーマット後にバッファをリロード
        if client.server_capabilities.documentFormattingProvider then
            vim.cmd([[
                augroup LspFormatting
                    autocmd! * <buffer>
                    autocmd BufWritePost <buffer> lua vim.lsp.buf.format({ async = true, filter = function(c) return c.name == "null-ls" end })
                    autocmd BufWritePost <buffer> :edit
                augroup END
            ]])
        end
    end,
})


