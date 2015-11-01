case "${OSTYPE}" in
    darwin*)
        #for macvim
        if [ -f /Applications/MacVim.app/Contents/MacOS/Vim ]; then
            alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
            alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
        fi

        ;;
    linux*)
        alias vi='/usr/bin/vim'
        alias vim='/usr/bin/vim'

        ;;
esac



