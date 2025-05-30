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
    layout = "float", -- "float" または "split"
  --   width = 0.2,      -- 画面幅の50%（float時）
  --   -- height = 0.5,     -- 画面高さの50%（float時）
  --   direction = "left", -- "left" または "right"（split時）
  --   -- splitの場合は direction = "right" なども指定可能
  },

})

