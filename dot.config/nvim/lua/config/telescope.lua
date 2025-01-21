local builtin = require('telescope.builtin')

-- プレフィックスを変数として定義
local telescope_prefix = ",f"  -- または好みのプレフィックス

vim.keymap.set('n', telescope_prefix .. 'f', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', telescope_prefix .. 'o', builtin.oldfiles, { desc = 'Telescope oldfiles files' })

vim.keymap.set('n', telescope_prefix .. '/', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', telescope_prefix .. 'b', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', telescope_prefix .. 'h', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', telescope_prefix .. 'gc', builtin.git_commits, { desc = 'Telescope git commit' })
vim.keymap.set('n', telescope_prefix .. 'gb', builtin.git_bcommits, { desc = 'Telescope git bcommit' })

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {

      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"

      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    picker_name = {
      find_files = {
        -- find_files picker の設定 (必要があれば)
        theme = "dropdown",
        hidden = true,
      },

    --   picker_config_key = value,
    --   ...
    }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
