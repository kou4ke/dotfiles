" -------------------------------------------------
" dein関連
" http://qiita.com/delphinus35/items/00ff2c0ba972c6e41542#_reference-b5863a53d77df63b23d4
" -------------------------------------------------

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.vim/cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let g:dein#auto_recache = 1

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" TOML を読み込み、キャッシュしておく
if dein#load_state(s:dein_dir)
  " プラグインリストを収めた TOML ファイル
  let s:toml      = '~/.vim/rc/dein.toml'
  let s:lazy_toml = '~/.vim/rc/dein_lazy.toml'
  " 設定開始
  call dein#begin(s:dein_dir, [s:toml, s:lazy_toml])
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  " 設定終了
  call dein#end()
  call dein#save_state()
endif


" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" -------------------------------------------------
" settings
" -------------------------------------------------
syntax on
filetype plugin indent on
set enc=utf-8
set fenc=utf-8
set fencs=utf-8,iso-2022-jp,euc-jp,cp932,sjis
" set nobackup
set backup
set backupdir=~/tmp/.vim/backup
set backupext=.back
set swapfile
set directory=~/tmp/.vim/swap
set updatecount=50
set number
set title
set cursorline     " カーソル行の背景色を変える
set cursorcolumn   " カーソル位置のカラムの背景色を変える
set ambiwidth=double
set expandtab
set tabstop=2
set shiftwidth=2
set smartindent
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

set nrformats-=octal
set hidden
set history=50
set virtualedit=block
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set wildmenu
set clipboard=unnamed
set laststatus=2
set termguicolors
set tags=.tags;$HOME

colorscheme molokai
highlight Comment ctermfg=243
highlight Visual  ctermbg=239

let mapleader = '\'

" pyenvのパスを追加
let g:python_host_prog = $HOME . '/.anyenv/envs/pyenv/shims/python2'
let g:python3_host_prog = $HOME . '/.anyenv/envs/pyenv/shims/python3'

" nodeのパスを追加
let g:node_host_prog = $HOME . '/.anyenv/envs/nodenv/versions/16.7.0/bin/neovim-node-host'
let $NVIM_NODE_LOG_FILE = $HOME . '/.vim/nvim-node.log'

source ~/dotfiles/vimrc.search
source ~/dotfiles/vimrc.denite
source ~/dotfiles/vimrc.deol
source ~/dotfiles/vimrc.syntastic
source ~/dotfiles/vimrc.template
source ~/dotfiles/vimrc.vimlsp
source ~/dotfiles/vimrc.defx
source ~/dotfiles/vimrc.fzf

" main operation
"カーソルを表示行で移動する。物理行移動は<C-n>,<C-p>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap gj j
nnoremap gk k


nnoremap <Space>l <C-l>
nnoremap ,lc :<C-u>lcd %:h<CR>
nnoremap <C-h> ^
vnoremap <C-h> ^
nnoremap <C-l> $
vnoremap <C-l> $
nnoremap <C-j> }
nnoremap <C-k> {
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-g> <Left>
inoremap <C-t> <Up>
inoremap <C-v> <Down>
inoremap <C-d> <Del>

" ファイルオープン関連(英字キーボードフォロー)
nnoremap <leader>n :enew<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :w<CR>:bd<CR>
nnoremap <leader>ss :w<CR>:bd<CR>
nnoremap <leader>qq :q<CR>
nnoremap <leader>cc :w<CR>:q<CR>
nnoremap <leader><ESC> :bd!<CR>
nnoremap <leader><ESC><ESC> :q!<CR>
nnoremap <leader>l :source ~/.vimrc<CR>:noh<CR>
nnoremap <leader>r :reg<CR>

" neovim向けのterminalモードの設定
if has('nvim')
  tnoremap <silent> <ESC> <C-\><C-n>
endif

" filetype判定の追加
autocmd BufRead,BufNewFile *.gs set filetype=javascript
autocmd BufRead,BufNewFile *.trigger set filetype=apex
autocmd BufRead,BufNewFile *.vue set filetype=vue
autocmd BufRead,BufNewFile *.toml set filetype=toml
autocmd BufRead,BufNewFile *.csv set filetype=csv
autocmd BufRead,BufNewFile *.tsv set filetype=tsv
autocmd FileType vue syntax sync fromstart

" tmuxでもset paste modo
if &term =~ "xterm" || &term =~ "screen"
  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  vnoremap <special> <expr> <Esc>[200~ XTermPasteBegin("c")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif


" vimshell
nnoremap <silent> vp :VimShellPop<CR>
augroup cmd_vimshell
  autocmd!
  autocmd Filetype vimshell nmap <silent><buffer>q <Plug>(vimshell_exit)
  autocmd Filetype vimshell nmap <silent><buffer>Q <Plug>(vimshell_hide)
augroup END

" tab operation
nnoremap [tab] <Nop>
nmap <leader>t [tab]

nnoremap [tab]n :<C-u>:tabnew<CR>
nnoremap [tab]l :<C-u>:tabnext<CR>
nnoremap [tab]h :<C-u>:tabprevious<CR>
nnoremap [tab]L :<C-u>:tablast<CR>
nnoremap [tab]H :<C-u>:tabfirst<CR>


" indent settings
augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.cs setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.php setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END
let g:indent_guides_enable_on_vim_startup = 1

" markdown preview用
command! MarkdownPreview call s:mark_down_preview()

function! s:mark_down_preview()
  let l:filename = @%
  let l:viewer = 'firefox'
  let l:open_cmd = 'open -a '
  let l:open_output = system(l:open_cmd.l:viewer.' '.l:filename)

  echo l:open_output
endfunction

" 半角スペース2つを全角に変換する
command! SpaceH2toZen call s:space_hankaku2_to_zenkaku()

function! s:space_hankaku2_to_zenkaku()
  execute '%s/  /　/g'
endfunction

" コメントの設定
if !exists('g:tcomment_types')
  let g:tcomment_types = {}
endif
let g:tcomment_types['tf'] = '# %s'
let g:tcomment_types['toml'] = '# %s'

" better white space
let g:strip_whitespace_on_save=0
let g:better_whitespace_filetypes_blacklist=['defx', 'denite']
nnoremap <leader>si :StripWhitespace<CR>

" typescript
let g:statline_syntastic = 0
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindo
