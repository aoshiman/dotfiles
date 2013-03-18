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


###{{{ 外観に関する設定
autoload -Uz colors
colors

# vcs_info
autoload vcs_info
# gitのみ有効にする
zstyle ":vcs_info:*" enable git
# commitしていない変更をチェックする
zstyle ":vcs_info:git:*" check-for-changes true
# gitリポジトリに対して、変更情報とリポジトリ情報を表示する
zstyle ":vcs_info:git:*" formats "%f%F{green}%c%u%f %f%F{green}%b%f"
# gitリポジトリに対して、コンフリクトなどの情報を表示する
zstyle ":vcs_info:git:*" actionformats "%f%F{green}%c%u<%a>%f %f%F{green}%b%f"
# addしていない変更があることを示す文字列
zstyle ":vcs_info:git:*" unstagedstr "%f%F{red}(add)%f"
# commitしていないstageがあることを示す文字列
zstyle ":vcs_info:git:*" stagedstr "%f%F{red}(commit)%f"

# git：まだpushしていないcommitあるかチェックする
my_git_info_push () {
  if [ "$(git remote 2>/dev/null)" != "" ]; then
    local head="$(git rev-parse HEAD)"
    local remote
    for remote in $(git rev-parse --remotes) ; do
      if [ "$head" = "$remote" ]; then return 0 ; fi
    done
    # pushしていないcommitがあることを示す文字列
    echo "%f%F{red}(push)%f"
  fi
}

# git：stashに退避したものがあるかチェックする
my_git_info_stash () {
  if [ "$(git stash list 2>/dev/null)" != "" ]; then
    # stashがあることを示す文字列
    echo "%f%F{blue}(stash)%f"
  fi
}

# vcs_infoの出力に独自の出力を付加する
my_vcs_info () {
  vcs_info
  echo $(my_git_info_stash)$(my_git_info_push)$vcs_info_msg_0_
}

setopt re_match_pcre
setopt prompt_subst

autoload -U compinit
compinit -u


# プロンプト
case ${UID} in
0)
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    ;;
*)
    #http://qiita.com/c200680c26e509a4f41c を参考にしてみた
    #http://0xcc.net/blog/archives/000032.html 深いディレクトリのパスを短くする
    PROMPT="%m %{${fg[yellow]}%}%(5~,%-2~/.../%2~,%~)%{${reset_color}%}%(?.%{$fg[green]%}.%{$fg[blue]%})%(?!(*'-') <!(*;-;%)? <)%{${reset_color}%}"
    PROMPT2='[%n]> '
    SPROMPT="%{$fg[red]%}%{$suggest%}(*'~'%)? < もしかして %B%r%b %{$fg[red]%}かな? [そう!(y), 違う!(n),a,e]:${reset_color}"
    RPROMPT='$(my_vcs_info)'

    function zle-line-init zle-keymap-select {
    case $KEYMAP in
        vicmd)
            RPROMPT='%{$fg[magenta]%}--NORNAL--%{${reset_color}%} $(my_vcs_info)'
            ;;
        main|viins)
            RPROMPT='%{$fg[cyan]%}--INSERT--%{${reset_color}%} $(my_vcs_info)'
            ;;
    esac
    zle reset-prompt
    }
    zle -N zle-line-init
    zle -N zle-keymap-select

;;
esac

# コマンドを実行するときに右プロンプトを消す。
setopt transient_rprompt

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# set screen terminal title
# Thanks https://github.com/afukuhara/dot.files/blob/master/.zshrc
preexec() {
    [ -n "${STY}" ] && echo -en "\ek${1%% 2%% *}\e\\"
}
precmd() {
    [ -n "${STY}" ] && echo -en "\ek$(basename $(pwd))\e\\"
}

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

###}}}
