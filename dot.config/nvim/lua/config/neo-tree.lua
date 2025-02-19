-- プレフィックスを変数として定義
local neotree_prefix = ",t"  -- または好みのプレフィックス

vim.keymap.set('n', neotree_prefix .. 'f', ':Neotree filesystem reveal left<CR>')
vim.keymap.set('n', neotree_prefix .. 't', ':Neotree toggle<CR>')

local neo_tree_width = 50

require("neo-tree").setup({

  use_nerdfonts = true,
  default_component_configs = {
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      default = "*",
      highlight = "NeoTreeFileIcon"
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        added     = "✚",
        modified  = "",
        deleted   = "✖",
        renamed   = "",
        -- Status type
        untracked = "",
        ignored   = "",
        unstaged  = "",
        staged    = "",
        conflict  = "",
      }
    },
  },
  filesystem = {
    window = {
      width = neo_tree_width  -- ここで幅を設定します。数値は任意で変更可能です。
    },
    use_libuv_file_watcher = false,
    follow_current_file = {
      enabled = true,
    },
  },
})
