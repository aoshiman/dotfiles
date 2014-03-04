case "${OSTYPE}" in
    darwin*)
        #for macvim
        if [ -f /Applications/MacVim.app/Contents/MacOS/Vim ]; then
            alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
            alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
        fi

        #for vim-py3
        alias viPY3='/usr/local/bin/vim'
        alias vimPY3='/usr/local/bin/vim'
        ;;
    linux*)
        alias vi='/usr/bin/vim'
        alias vim='/usr/bin/vim'

        #for vim-py3
        alias viPY3='/usr/local/bin/vim'
        alias vimPY3='/usr/local/bin/vim'
        ;;
esac



