local gitlinker = require('gitlinker')
local gitlinker_prefix = ",g"  -- または好みのプレフィックス

vim.keymap.set('n', gitlinker_prefix .. 'l', ':GitLink<CR>')
vim.keymap.set('n', gitlinker_prefix .. 'b', ':GitLink blame<CR>')
vim.keymap.set('n', gitlinker_prefix .. 'c', ':GitLink current_branch<CR>')

gitlinker.setup {}
