" -------------------------------------------------
" dein関連 
" http://qiita.com/delphinus35/items/00ff2c0ba972c6e41542#_reference-b5863a53d77df63b23d4
" -------------------------------------------------

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.vim/cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

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
set nobackup
set number
set title
set ambiwidth=double
set expandtab
set tabstop=2
set shiftwidth=2
set smartindent
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
highlight WideSpace ctermbg=blue guibg=blue
highlight EOLSpace ctermbg=red guibg=red

set nrformats-=octal
set hidden
set history=50
set virtualedit=block
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set wildmenu
set clipboard=unnamed
set laststatus=2

colorscheme molokai

source ~/dotfiles/vimrc.search
source ~/dotfiles/vimrc.unite
source ~/dotfiles/vimrc.syntastic
source ~/dotfiles/vimrc.completion
source ~/dotfiles/vimrc.git
source ~/dotfiles/vimrc.vimfiler
source ~/dotfiles/vimrc.omnisharp

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

" vimshell
nnoremap <silent> vp :VimShellPop<CR>

" tab operation
nnoremap <silent> tn<CR> :<C-u>:tabnew<CR>
nnoremap <silent> tc<CR> :<C-u>:tabclose<CR>

" indent settings
augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.cs setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

" lightline.vim
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"[R]":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
      \ },
      \ 'separator': { 'left': '|', 'right': '|' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

