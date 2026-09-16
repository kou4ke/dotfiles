-- tflint 用の none-ls カスタムソース
--
-- tflint は none-ls / null-ls のビルトインに存在しない。null-ls 時代に
-- `null_ls.builtins.diagnostics.tflint` を指定していたが、これは常に nil を返しており
-- sources テーブルに穴を作って後続のソースごと登録を落としていた。
local helpers = require("null-ls.helpers")
local methods = require("null-ls.methods")

local severities = {
    error = helpers.diagnostics.severities["error"],
    warning = helpers.diagnostics.severities["warning"],
    notice = helpers.diagnostics.severities["information"],
}

---tflint の range / message / severity を null-ls の診断に変換する
---@param range table|nil tflint の range（filename, start, end）。プラグイン初期化失敗など位置を持たないものは nil
---@param message string|nil
---@param severity string|nil tflint の severity（error / warning / notice）
---@param code string|nil 診断に付けるコード（ルール名やエラー種別）
---@return table|nil
local function to_diagnostic(range, message, severity, code)
    if not message then
        return nil
    end

    local start_pos = range and range.start
    local diagnostic = {
        -- 位置を持たないエラー（`tflint --init` 未実行など）は先頭行に出して気付けるようにする
        row = start_pos and start_pos.line or 1,
        col = start_pos and start_pos.column or 1,
        message = message,
        severity = severities[severity] or severities.warning,
        code = code,
    }

    if range and range["end"] then
        diagnostic.end_row = range["end"].line
        diagnostic.end_col = range["end"].column
    end

    return diagnostic
end

return helpers.make_builtin({
    name = "tflint",
    meta = {
        url = "https://github.com/terraform-linters/tflint",
        description = "Terraform 用のプラガブルなリンター",
    },
    -- tflint はバッファではなくディスク上のモジュールディレクトリを読むため、保存時のみ実行する
    method = methods.internal.DIAGNOSTICS_ON_SAVE,
    filetypes = { "terraform", "tf" },
    generator_opts = {
        command = "tflint",
        -- --filter は「プロセスの cwd からの相対パス」にしか一致しない。--chdir と併用すると
        -- 常に0件になるため、cwd をモジュールディレクトリに固定してファイル名だけを渡す。
        cwd = function(params)
            return vim.fs.dirname(params.bufname)
        end,
        args = function(params)
            return {
                -- ルール違反の検出だけでは exit 0 にする
                "--force",
                "--format=json",
                "--filter=" .. vim.fs.basename(params.bufname),
            }
        end,
        format = "json",
        to_stdin = false,
        from_stderr = false,
        ignore_stderr = true,
        -- --force が効くのはルール違反だけで、HCL のパースエラーやプラグイン初期化失敗では
        -- exit 1 になる。これらも errors[] として JSON に出るので受け取る。
        check_exit_code = { 0, 1 },
        on_output = function(params)
            local output = params.output
            if type(output) ~= "table" then
                return {}
            end

            local diagnostics = {}

            -- ルール違反。severity は rule 側に入っている
            for _, issue in ipairs(output.issues or {}) do
                local rule = issue.rule or {}
                local diagnostic = to_diagnostic(issue.range, issue.message, rule.severity, rule.name)
                if diagnostic then
                    table.insert(diagnostics, diagnostic)
                end
            end

            -- HCL のパースエラーなど。severity はトップレベルに入っている
            for _, err in ipairs(output.errors or {}) do
                local diagnostic = to_diagnostic(err.range, err.message, err.severity, err.summary)
                if diagnostic then
                    table.insert(diagnostics, diagnostic)
                end
            end

            return diagnostics
        end,
    },
    factory = helpers.generator_factory,
})
