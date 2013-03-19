#色々コピペしたけど下記URLには特に参考にさせていただきました
#http://yuyunko.hatenablog.com/entry/20101112/1289551129
#コピペしておきながら全部把握していない。。

###{{{ 環境設定
export EDITOR='vim'
#export TERM=dtterm #iTermで矢印が効かない時の対応らしいが使ってない


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
export PATH=/usr/local/bin:$PATH
#zsh function
fpath=(${HOME}/.zsh/functions/Completion ${fpath})

###}}}


###{{{ 補完など
# auto change directory
#
setopt auto_cd
function chpwd() { ls }

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

###}}}


###{{{ Function

function cdup() {
echo
cd ..
zle reset-prompt
}
zle -N cdup
bindkey '\^' cdup

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

[ -f ${HOME}/.zshrc.screen_autoload ] && source ${HOME}/.zshrc.screen_autoload
[ -f ${HOME}/.zshrc.python ] && source ${HOME}/.zshrc.python
[ -f ${HOME}/.zshrc.osx ] && source ${HOME}/.zshrc.osx
[ -f ${HOME}/.zshrc.prompt ] && source ${HOME}/.zshrc.prompt
[ -f ${HOME}/.zshrc.prompt_light ] && source ${HOME}/.zshrc.prompt_light

###}}}
