set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

""" Vundle自身
Bundle 'gmarik/vundle'

""" カラースキーム
Bundle 'altercation/vim-colors-solarized'

""" ステータスライン
Bundle 'Lokaltog/vim-powerline'

""" ファイラー
Bundle 'scrooloose/nerdtree'
Bundle 'Shougo/unite.vim'

""" 文字コード自動判定
Bundle 'banyan/recognize_charcode.vim'

""" テンプレート
Bundle 'mattn/sonictemplate-vim'

""" 開発Tools
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'davidhalter/jedi-vim'
Bundle 'mitechie/pyflakes-pathogen'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'Shougo/vimproc'
Bundle 'thinca/vim-quickrun'
Bundle 'scrooloose/nerdcommenter'

filetype plugin indent on

""" シンタックスの色づけ有効
syntax enable
set background=dark

""" カラースキーム
colorscheme solarized

""" インデント
set autoindent
set expandtab       " tab を空白文字に置き換え
set shiftwidth=4    " tab 文字の入力幅（自動インデントの時）
set tabstop=4       " tab 文字の表示幅（既存ファイル展開時のタブ表示幅）
set softtabstop=4   " キーボードでtab 文字を入力した時の入力幅
""" 削除
set backspace=indent,eol,start  " BS で indent,改行,挿入開始前を削除
set smarttab        " BS でインデント幅を削除

"""キーマップ
" USKeyboard対策
nnoremap ; :
nnoremap : ;
" .vimrcを開く
nnoremap <Leader>v  :<C-u>edit $MYVIMRC<CR>
" source ~/.vimrc を実行する。
nnoremap <Leader>s  :<C-u>source $MYVIMRC<CR>

""" 検索
set hlsearch        " 検索文字列を色づけ
nmap <Esc><Esc> ;nohlsearch<CR><Esc>
set ignorecase      " 大文字小文字を判別しない
set smartcase       " でも大文字小文字が混ざって入力されたら区別する
set incsearch       " インクリメンタルサーチ

""" コマンド履歴保存数
set history=100

""" コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu wildmode=list:longest,full

""" メニューの日本語化
set langmenu=ja_JP.utf-8

""" 文字コード（Mac 用に utf-8 ベース。Win なら cp932 ベースにする）
set encoding=utf-8       " vim 内部の文字コード（ブランクバッファの文字コードに影響）
set fileencoding=utf-8      " デフォルトのファイル文字コード

""" 表示
set number
set cursorline
set cursorcolumn
""" set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set laststatus=2
set notitle "VIMを使ってくれてありがとうのメッセージを表示させない

""" バックアップ
set nobackup          " ファイル上書きでバックアップファイルを作成
""" set backupdir=/tmp  " バックアップファイルの保存場所
set autoread        " Vimの外部で変更されたことが判明したとき、自動的に読み直す
set noswapfile      " スワップファイルの作成は行わない
set hidden          " 保存しないで他のファイルを表示することが出来るようにする
set ruler           " ルーラを表示
""" set showcmd         " 入力中のコマンド（キー）を右下に表示
""" set wildmenu        " 入力中のタブ補完を強化
""" set wildmode=list:longest,full " 入力補完の設定（リスト表示で最長一致、その後選択）
set showmatch       " 括弧入力で対応する括弧を一瞬強調

""" template
autocmd BufNewFile *.py 0r ~/.vim/template/python.txt

""" Function
""" create directory automatically
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'),v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
       \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END

""" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
""" 保存時にtabをスペースに変換する
autocmd BufWritePre * :%s/\t/  /ge


""" Config for Plugin
""" NERDTree
let file_name = expand("%")
if has('vim_starting') &&  file_name == ""
    autocmd VimEnter * NERDTree ./
endif

""" quickrun + vimproc
let g:quickrun_config = {}
let g:quickrun_config['*'] = {'runner': 'vimproc'}
let g:quickrun_no_default_key_mappings = 1
nmap <Leader>p <Plug>(quickrun)
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

""" Nerd_Commenter の基本設定
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
nmap <Leader>c <Plug>NERDCommenterToggle
vmap <Leader>c <Plug>NERDCommenterToggle
