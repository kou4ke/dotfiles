-- none-ls.nvim（アーカイブ済み null-ls.nvim の後継 fork）の設定。
-- モジュール名は fork 後も "null-ls" のままなので require 名は変わらない。
local null_ls = require("null-ls")
local lsp_diagnostic = require("config.lsp-diagnostic")

null_ls.setup({
    temp_dir = os.getenv("HOME").."/tmp/.nvim/null-ls",
    sources = {
        -- Lintツールの設定
        -- eslint 系は none-ls 本体から none-ls-extras.nvim に移された
        require("none-ls.diagnostics.eslint_d"),  -- 高速なESLint
        -- require("none-ls.diagnostics.eslint"),  -- 通常のESLint（高速版を使わない場合）
        require("config.none-ls-tflint"),  -- Terraformのリント（ビルトインが無いため自作）

        -- フォーマットツールの設定
        null_ls.builtins.formatting.prettier.with({
            filetypes = {"vue", "javascript", "typescript", "css", "html", "json"}
        }),
        -- Pintフォーマッターの設定
        -- ホストの PHP は 8.2 系で pint の要求（^8.3）を満たさないため、コンテナの pint を使う。
        -- pint はファイルを上書きするだけで stdout に整形結果を出さないので、コンテナ内の
        -- 一時ファイルを経由して結果を stdout に流し、それを null-ls に渡す。
        -- ホスト側のパスをコンテナに渡す方式（旧設定）は
        --   - nvim の cwd が src/ でないとパスが解決できない
        --   - null-ls が読み戻す一時ファイルは pint が触らないため、
        --     ディスクだけ整形されてバッファが古いまま残る
        -- という二重の問題があったため、stdin 経由に変更した。
        null_ls.builtins.formatting.pint.with({
            filetypes = { "php" },
            -- generator_opts ごと差し替える。make_builtin が with() の直下から拾うキーは
            -- whitelist 制で to_stdin が含まれないため、そこに書いても無視される。
            -- ビルトインの to_temp_file = true（一時ファイルを読み戻す）も併せて打ち消す。
            generator_opts = {
                command = "docker",
                args = {
                    "compose",
                    "exec",
                    "-T",
                    "app",
                    "sh",
                    "-c",
                    -- composer fmt の実体（src/composer.json）。コンテナの作業ディレクトリが
                    -- /work/src なので pint.json もそのまま参照される
                    'tmp=$(mktemp /tmp/nvim-pint-XXXXXX.php) && cat > "$tmp" && '
                        .. './vendor/bin/pint --no-interaction --quiet "$tmp" >/dev/null 2>&1; '
                        .. 'cat "$tmp"; rm -f "$tmp"',
                },
                to_stdin = true,
                to_temp_file = false,
            },
        }),

        -- Terraformフォーマッターの設定
        null_ls.builtins.formatting.terraform_fmt.with({
            command = "terraform",
            args = { "fmt", "-" },
            filetypes = { "terraform" }
        }),
    },
    on_attach = function(client, bufnr)
        lsp_diagnostic.on_attach(client, bufnr)

        if not client.server_capabilities.documentFormattingProvider then
            return
        end

        -- 保存前に同期でフォーマットする。
        -- 旧設定は BufWritePost + async = true + :edit だった。これは整形結果がバッファに
        -- 入るのが書き込み後になるため、1回目の :w ではディスクに整形結果が残らず
        -- バッファだけが modified で取り残される（pint は :edit のタイミングも噛み合わず
        -- ディスクとバッファが食い違っていた）。
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("NoneLsFormatting" .. bufnr, { clear = true }),
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    async = false,
                    bufnr = bufnr,
                    filter = function(c)
                        return c.name == "null-ls"
                    end,
                })
            end,
        })
    end,
})
