########################################
# 環境変数
export LANG=ja_JP.UTF-8

# 色を使用出来るようにする
autoload -Uz colors
colors

# emacs 風キーバインドにする
bindkey -e

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# プロンプト
# 1行表示
# PROMPT="%~ %# "
# 2行表示
PROMPT="%{${fg[yellow]}%}%D %T%{${reset_color}%}%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%# "


# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# .ssh/configからホスト名を補完
_cache_hosts=(`cat ~/.ssh/config | grep "^Host"|awk '{print $2}'`)
_cache_hosts+=(`cat ~/.ssh/ssh_conf.d/*/* | grep "^Host"|awk '{print $2}'`)

########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg


########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

########################################
# エイリアス

alias ll='ls -la'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias grep="grep --color"

alias g="hub"
alias tf="terraform"
alias tfi="terraforming"

alias mkdir='mkdir -p'

alias cl='cal `date '+%Y'`'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '


########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        alias -g vim='nvim'
        alias -g vif='nvim -c "Defx -show-ignored-files -buffer-name=defx"'
        alias -g vr='open -a vimR'
        alias -g fdr='open -a finder ./'
        alias -g vh='sudo nvim /etc/hosts'
        alias updatedb='sudo /usr/libexec/locate.updatedb'
        ;;
    linux*)
        PROMPT="%{${fg[yellow]}%}%D %T%{${reset_color}%}%{${fg[cyan]}%}[%n@%m]%{${reset_color}%} %~
%# "
        #Linux用の設定
        alias ls='ls -F --color=auto'
        alias -g vim='nvim'
        export GIT_EDITOR='nvim'
        ;;
esac

# vim:set ft=zsh:

if [ -e $HOME/.zsh_settings ];then
    source $HOME/.zsh_settings
fi

if [ -e $HOME/.zshfunc ];then
    source $HOME/.zshfunc
fi

# 初回シェル時のみ tmux実行
if [ $SHLVL = 1 ]; then
  tmux attach || tmux
fi

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/kosuke/work/git/sf_datasync_docker/sf_datasync/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/kosuke/work/git/sf_datasync_docker/sf_datasync/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/kosuke/work/git/sf_datasync_docker/sf_datasync/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/kosuke/work/git/sf_datasync_docker/sf_datasync/node_modules/tabtab/.completions/sls.zsh
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
