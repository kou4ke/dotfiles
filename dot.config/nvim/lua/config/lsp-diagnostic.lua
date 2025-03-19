local M = {}

function M.on_attach(client, bufnr)
    print("LSP attached: " .. client.name)  -- LSPサーバー名を出力

    -- フォーマットの自動実行
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_augroup("LspFormatting", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = "LspFormatting",
            buffer = bufnr,
            callback = function()
                print("Formatting with null-ls")  -- デバッグ情報を追加
                vim.lsp.buf.format({
                    bufnr = bufnr,
                    filter = function(c)
                        return c.name == "null-ls"
                    end
                })
            end,
        })
    end

    -- キーマッピングの設定
    vim.keymap.set('n', ',do', vim.diagnostic.open_float, { buffer = bufnr, noremap = true, silent = true })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr, noremap = true, silent = true })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr, noremap = true, silent = true })
    vim.keymap.set('n', ',dq', vim.diagnostic.setloclist, { buffer = bufnr, noremap = true, silent = true })
    vim.keymap.set('n', ',df', function()
        print("Manual format with null-ls")  -- デバッグ情報を追加
        vim.lsp.buf.format({
            async = true,
            filter = function(c)
                return c.name == "null-ls"
            end,
            callback = function()
                vim.schedule(function()
                    vim.cmd('edit')
                end)
            end
        })
    end, { buffer = bufnr, noremap = true, silent = true })
    vim.keymap.set('n', ',dc', vim.lsp.buf.code_action, { buffer = bufnr, noremap = true, silent = true })
end

return M
