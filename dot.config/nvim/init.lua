-- Initialize package manager (using lazy.nvim instead of dein)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader key
vim.g.mapleader = '\\'

-- プラグイン設定の読み込み
require("lazy").setup("plugins")

-- Basic Settings
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = {'utf-8', 'iso-2022-jp', 'euc-jp', 'cp932', 'sjis'}
vim.opt.backup = true
vim.opt.backupdir = vim.fn.expand('~/tmp/.vim/backup')
vim.opt.backupext = '.back'
vim.opt.swapfile = true
vim.opt.directory = vim.fn.expand('~/tmp/.vim/swap')
vim.opt.updatecount = 50
vim.opt.number = true
vim.opt.title = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- Check if running in VSCode
if vim.g.vscode then
  vim.opt.ambiwidth = 'single'
else
  vim.opt.ambiwidth = 'double'
end

-- Indentation settings
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.listchars = {
  tab = '»-',
  trail = '-',
  eol = '↲',
  extends = '»',
  precedes = '«',
  nbsp = '%'
}

-- Additional settings
vim.opt.nrformats:remove('octal')
vim.opt.hidden = true
vim.opt.history = 50
vim.opt.virtualedit = 'block'
vim.opt.whichwrap = 'b,s,[,],<,>'
vim.opt.backspace = 'indent,eol,start'
vim.opt.wildmenu = true
vim.opt.clipboard = 'unnamed'
vim.opt.laststatus = 2
vim.opt.termguicolors = true
vim.opt.tags = '.tags;$HOME'

-- Color scheme
vim.cmd('colorscheme molokai')
vim.cmd('highlight Comment ctermfg=243')
vim.cmd('highlight Visual ctermbg=239')

-- Language providers
vim.g.python_host_prog = vim.fn.expand('$HOME/.anyenv/envs/pyenv/shims/python2')
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.node_host_prog = vim.fn.expand('$HOME/.anyenv/envs/nodenv/versions/22.12.0/bin/neovim-node-host')
vim.g.ruby_host_prog = vim.fn.expand('$HOME/.local/share/gem/ruby/3.2.0/gems/neovim-0.10.0/exe/neovim-ruby-host')
vim.g.loaded_perl_provider = 0

-- Key mappings
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Cursor movement
map('n', 'j', 'gj')
map('n', 'k', 'gk')
map('n', '<Down>', 'gj')
map('n', '<Up>', 'gk')

map('n', 'gj', 'j')

map('n', 'gk', 'k')


-- Additional mappings
map('n', '<Space>l', '<C-l>')
map('n', ',lc', ':lcd %:h<CR>')

map('n', '<C-h>', '^')
map('v', '<C-h>', '^')
map('n', '<C-l>', '$')
map('v', '<C-l>', '$')
map('n', '<C-j>', '}')
map('n', '<C-k>', '{')

-- Insert mode mappings

map('i', '<C-f>', '<Right>')
map('i', '<C-b>', '<Left>')
map('i', '<C-g>', '<Left>')
map('i', '<C-t>', '<Up>')
map('i', '<C-v>', '<Down>')
map('i', '<C-d>', '<Del>')

-- File operations
map('n', '<leader>n', ':enew<CR>')
map('n', '<leader>w', ':w<CR>')
map('n', '<leader>q', ':w<CR>:bd<CR>')
map('n', '<leader>ss', ':w<CR>:bd<CR>')
map('n', '<leader>qq', ':q<CR>')
map('n', '<leader>cc', ':w<CR>:q<CR>')
map('n', '<leader><ESC>', ':bd!<CR>')
map('n', '<leader><ESC><ESC>', ':q!<CR>')
map('n', '<leader>l', ':source ~/.config/nvim/init.lua<CR>:noh<CR>')
map('n', '<leader>r', ':reg<CR>')

-- Terminal mode mappings

if vim.fn.has('nvim') == 1 then
  map('t', '<ESC>', '<C-\\><C-n>')
end

-- Filetype detection

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.gs",
  command = "set filetype=javascript"
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.trigger",
  command = "set filetype=apex"
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.vue",
  command = "set filetype=vue"
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.toml", "*.csv", "*.tsv" },
  callback = function()
    vim.opt_local.filetype = vim.fn.expand("%:e")

  end
})

-- Tab operations
map('n', '<leader>tt', ':tabnew<CR>')

map('n', '<leader>tn', ':tabnext<CR>')
map('n', '<leader>tl', ':tabnext<CR>')
map('n', '<leader>th', ':tabprevious<CR>')
map('n', '<leader>tL', ':tablast<CR>')
map('n', '<leader>tH', ':tabfirst<CR>')

-- Indentation settings for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cs", "php" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end
})

-- Daily Memo function
vim.api.nvim_create_user_command('EditDailyMemo', function()
  local daily_memo_dir = vim.fn.expand('~/tmp')
  if vim.fn.isdirectory(vim.env.DAILY_MEMO_DIR or '') == 1 then
    daily_memo_dir = vim.env.DAILY_MEMO_DIR
  end
  local memo_dir = string.format('%s/%s/%s', daily_memo_dir, 

    os.date('%Y'), os.date('%m'))
  local memo_file = string.format('%s/%s.txt', memo_dir, os.date('%d'))
  vim.fn.mkdir(memo_dir, 'p')
  vim.cmd('edit ' .. memo_file)
end, {})

map('n', '<Leader>m', ':EditDailyMemo<CR>')

-- Markdown preview command
vim.api.nvim_create_user_command('MarkdownPreview', function()
  local filename = vim.fn.expand('%')
  local viewer = 'firefox'
  local open_cmd = 'open -a '
  local open_output = vim.fn.system(open_cmd .. viewer .. ' ' .. filename)
  print(open_output)
end, {})


-- Space conversion command
vim.api.nvim_create_user_command('SpaceH2toZen', function()
  vim.cmd([[%s/  /　/g]])
end, {})


-- Better whitespace settings
vim.g.strip_whitespace_on_save = 0
vim.g.better_whitespace_filetypes_blacklist = {'defx', 'denite'}
map('n', '<leader>si', ':StripWhitespace<CR>')


-- Quickfix settings

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = {"[^l]*"},
  command = "nested cwindow"
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = {"l*"},
  command = "nested lwindow"
})
