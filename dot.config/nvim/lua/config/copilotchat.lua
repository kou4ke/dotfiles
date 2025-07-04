local copilotchat_prefix = ",c"  -- または好みのプレフィックス
vim.keymap.set('n', copilotchat_prefix .. 'o', ':CopilotChatToggle<CR>')

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
    -- layout = "split", -- "float" または "split"
    width = 0.4,      -- 画面幅の50%（float時）
  --   -- height = 0.5,     -- 画面高さの50%（float時）
    direction = "left", -- "left" または "right"（split時）
  --   -- splitの場合は direction = "right" なども指定可能
  },

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
      end
    end
  end,
})

