#色々コピペしたけど下記URLには特に参考にさせていただきました
#http://yuyunko.hatenablog.com/entry/20101112/1289551129
#コピペしておきながら全部把握していない。。

###{{{ 環境設定
export EDITOR='vim'
#export TERM=dtterm #iTermで矢印が効かない時の対応らしいが使ってない
#
umask 022
#umask値はファイルなら666 の補数、ディレクトリなら777 の補数
#umask 022 は補数から022を引いたパーミッションを作成する設定

###}}}


###{{{ 言語設定
export LANG=ja_JP.UTF-8
case ${UID} in
0)
    LANG=C
    ;;
esac


###}}}


###{{{ パスの設定
#export PATH=/opt/local/bin:/opt/local/sbin/:$PATH
# $PATHは現在のパス一覧を表す。先頭に追加pathしたければ$PATHより前に記述
export PATH=/usr/local/bin:$PATH
#zsh function
fpath=(${HOME}/.zsh/functions/Completion/zsh-completions ${fpath})
# パスの重複除去 path追加設定よりも後ろに記述すること
typeset -U path cdpath fpath manpath

# zshの警告解除
setopt nonomatch

###}}}


###{{{ 補完など
# auto change directory
#
setopt auto_cd
# function chpwd() { ls }

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

# 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt auto_menu

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# カッコの対応などを自動的に補完する
setopt auto_param_keys


###}}}


###{{{ キーバインド

bindkey -v
#zle-line-init() { zle -K vicmd; } ; zle -N zle-line-init

# bindkey -v でもコマンドラインスタック使う
# http://qiita.com/items/1f2c7793944b1f6cc346
show_buffer_stack() {
    POSTDISPLAY="
    stack: $LBUFFER"
    zle push-line-or-edit
}
zle -N show_buffer_stack
setopt noflowcontrol
bindkey '^Q' show_buffer_stack

# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end
bindkey "^r" history-incremental-search-backward

# ctrl-w, ctrl-bキーで単語移動
# https://github.com/tokuda109/dotfiles/blob/master/zshrc
bindkey "^W" forward-word
bindkey "^B" backward-word

###}}}


###{{{ 履歴(history)に関する設定

HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data



###}}}


###{{{ alias

setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    alias sudo="sudo "
    ;;
esac

alias la="ls -al"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

#cdup
alias -g ....="../.."
alias -g ......="../../.."

#git
alias gti="git"

###}}}


###{{{ Function
# ＾でディレクトリをあがる
# function cdup() {
# echo
# cd ..
# zle reset-prompt
# }
# zle -N cdup
# bindkey '^\^' cdup


# Function for VirtualBox
function startvm () {
    VBoxmanage startvm "$1" -type headless
}

function stopvm () {
    VBoxmanage controlvm "$1" savestate
}

function listvm () {
    VBoxmanage list runningvms
}

function listallvm () {
    VBoxmanage list vms
}


# http://qiita.com/items/160a13a95e9627a55750
# Check 256 Color
function 256colortest() {
    local code
    for code in {0..255}; do
        echo -e "\e[38;05;${code}m $code: Test"
    done
}


##}}}


###{{{ Other


case "${TERM}" in
xterm*|xterm-color)
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm-color)
    stty erase '^H'
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm)
    stty erase '^H'
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
jfbterm-color)
    export LSCOLORS=gxFxCxdxBxegedabagacad
    export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac


###}}}


###{{{ load user .zshrc configuration file
# screenのオートデタッチ＆アタッチ
[ -f ${HOME}/.zshrc.screen_autoload ] && source ${HOME}/.zshrc.screen_autoload

# Virtualenv等の設定
[ -f ${HOME}/.zshrc.python ] && source ${HOME}/.zshrc.python

# MacVimのPath等
[ -f ${HOME}/.zshrc.osx ] && source ${HOME}/.zshrc.osx

# Node.jsの設定
[ -f ${HOME}/.zshrc.node ] && source ${HOME}/.zshrc.node

# Promptの設定、もっさりしていたらlightを使用（stash等は表示されない）
[ -f ${HOME}/.zshrc.prompt ] && source ${HOME}/.zshrc.prompt
[ -f ${HOME}/.zshrc.prompt.remote ] && source ${HOME}/.zshrc.prompt.remote
[ -f ${HOME}/.zshrc.prompt_light ] && source ${HOME}/.zshrc.prompt_light

###}}}
