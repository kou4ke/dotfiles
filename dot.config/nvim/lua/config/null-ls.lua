local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- Lintツールの設定
        null_ls.builtins.diagnostics.eslint_d,  -- 高速なESLint
        -- null_ls.builtins.diagnostics.eslint,  -- 通常のESLint（高速版を使わない場合）
        
        -- フォーマットツールの設定

        null_ls.builtins.formatting.prettier.with({
            filetypes = {"vue", "javascript", "typescript", "css", "html", "json"}
        }),
    },
    {
        -- Pintフォーマッターの設定
        null_ls.builtins.formatting.pint.with({
            command = "vendor/bin/pint",  -- pintのパスを指定
            filetypes = { "php" }
        }),
    },
    on_attach = function(client, bufnr)
        -- フォーマットの自動実行
        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_augroup("LspFormatting", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = "LspFormatting",
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end

        -- キーマッピングの設定
        local opts = { noremap=true, silent=true }
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ne", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>nq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>nf", "<cmd>lua vim.lsp.buf.format({async=true})<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>nc", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    end,
})
