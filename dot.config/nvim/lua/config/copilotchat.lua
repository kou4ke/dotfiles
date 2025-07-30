local copilotchat_prefix = ",c"  -- または好みのプレフィックス
local default_prompts = require('CopilotChat.config.prompts')
local in_japanese = 'なお、説明は日本語でお願いします。'
vim.keymap.set('n', copilotchat_prefix .. 'o', ':CopilotChatToggle<CR>')
vim.keymap.set( { 'n', 'x' }, copilotchat_prefix .. 'c', '<cmd>CopilotChat<cr>', { desc = 'CopilotChat' })
vim.keymap.set( { 'n', 'x' }, copilotchat_prefix .. 'p', '<cmd>CopilotChatPrompts<cr>', { desc = 'CopilotChat predefined prompts' })
vim.keymap.set( { 'n', 'x' }, copilotchat_prefix .. 'e', '<cmd>CopilotChatExplain<cr>', { desc = 'CopilotChat Explain' })
vim.keymap.set( { 'n', 'x' }, copilotchat_prefix .. 't', '<cmd>CopilotChatTranslateJE<cr>', { desc = 'CopilotChat TranslateJE' })


require("CopilotChat").setup({
  -- Optional, defaults to `false`
  auto_open = true,
  -- Optional, defaults to `false`
  auto_close = true,
  -- Optional, defaults to `false`
  auto_select = false,
  -- Optional, defaults to `false`
  auto_select_first = false,
  -- Optional, defaults to `false`
  auto_select_last = false,
  window = {
    layout = "float", -- "float" または "split"
    width = 0.6,      -- 画面幅の50%（float時）
    height = 0.6,     -- 画面高さの50%（float時）
    -- direction = "left", -- "left" または "right"（split時）
    -- splitの場合は direction = "right" なども指定可能
    close_on_escape = true,
  },
  prompts = vim.tbl_deep_extend('force', default_prompts, {
    -- ビルトインのプロンプトを日本語化
    Commit = { prompt = default_prompts.Commit.prompt .. in_japanese },
    Docs = { prompt = default_prompts.Docs.prompt .. in_japanese },
    Explain = { prompt = default_prompts.Explain.prompt .. in_japanese },
    Review = { prompt = default_prompts.Review.prompt .. in_japanese },
    Fix = { prompt = default_prompts.Fix.prompt .. in_japanese },
    Optimize = { prompt = default_prompts.Optimize.prompt .. in_japanese },
    Tests = { prompt = default_prompts.Tests.prompt .. in_japanese },
    -- 日英翻訳のプロンプトを独自に追加
    TranslateJE = {
      prompt = 'Translate the selected text from English to Japanese if it is in English, or from Japanese to English if it is in Japanese. Please do not include unnecessary line breaks, line numbers, comments, etc. in the result.',
      system_prompt = 'You are an excellent Japanese-English translator. You can translate the original text correctly without losing its meaning. You also have deep knowledge of system engineering and are good at translating technical documents.',
      description = 'Translate text from Japanese to English or vice versa',
    },
  }),

})

-- 履歴の自動保存と読み込み
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "copilot-chat" then
      vim.cmd("write! ~/tmp/.vim/copilotchat_history.txt")
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "copilot-chat" then
      local f = io.open(os.getenv("HOME") .. "/tmp/.vim/copilotchat_history.txt", "r")
      if f then
        local content = f:read("*a")
        f:close()
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(content, "\n"))
        vim.api.nvim_win_set_cursor(0, {vim.api.nvim_buf_line_count(0), 0})
      end
    end
  end,
})

