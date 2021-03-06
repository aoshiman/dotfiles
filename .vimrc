""" Vim Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

""" ヘルプ
Plug 'vim-jp/vimdoc-ja'

""" カラースキーム
Plug 'altercation/vim-colors-solarized'

""" ステータスライン
Plug 'itchyny/lightline.vim'

""" ファイラー・バッファ管理
Plug 'scrooloose/nerdtree',  { 'on': 'NERDTreeToggle' }
Plug 'sandeepcr529/Buffet.vim'

""" 文字コード自動判定
Plug 'banyan/recognize_charcode.vim'

""" テンプレートエンジン
Plug 'Shougo/neosnippet'
""" テンプレート
Plug 'honza/vim-snippets'

""" 辞書
" Plug 'koron/dicwin-vim'

""" 開発支援
Plug 'nathanaelkane/vim-indent-guides'
Plug 'jmcantrell/vim-virtualenv'
" Plug 'miyakogi/vim-virtualenv'
" Plug 'aoshiman/vim-virtualenv'
Plug 'mitechie/pyflakes-pathogen'
Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-surround'
Plug 'Shougo/vimproc', { 'do': 'make' }
" Plug 'thinca/vim-quickrun'
Plug 'scrooloose/nerdcommenter'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'davidhalter/jedi-vim' , { 'for': 'python' }

"" http://layzie.hatenablog.com/entry/20130122/1358811539
Plug 'jiangmiao/simple-javascript-indenter'
Plug 'itspriddle/vim-jquery'
Plug 'jelera/vim-javascript-syntax'
" Plug 'scrooloose/syntastic'
" Plug 'python_fold'

" Plug 'lilydjwg/colorizer'
" colorizerを有効にしているとdicwin.vimのレスポンスが
" 悪いので気を付ける
" Plug 'pasela/unite-webcolorname'
Plug 'vim-scripts/nginx.vim'
" Plug 'gcmt/wildfire.vim'
Plug 'chase/vim-ansible-yaml'

""" ユーティリティ
Plug 'sudo.vim'
Plug 'Shougo/vimshell'
Plug 'Shougo/neocomplcache'
Plug 'rhysd/clever-f.vim'
" Plug 'kana/vim-arpeggio'

" Add plugins to &runtimepath
call plug#end()

filetype plugin indent on

""" シンタックスの色づけ有効
syntax enable
set background=dark

""" カラースキーム
colorscheme solarized
let g:solarized_termcolors=16
let g:solarized_termtrans=1
let g:solarized_degrade=0
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
let g:solarized_contrast='normal'
let g:solarized_visibility='normal'

""" インデント
set autoindent
set expandtab       " tab を空白文字に置き換え
set shiftwidth=4    " tab 文字の入力幅（自動インデントの時）
set tabstop=4       " tab 文字の表示幅（既存ファイル展開時のタブ表示幅）
set softtabstop=4   " キーボードでtab 文字を入力した時の入力幅

set list
set listchars=tab:>- " tabがある場合表示させる

""" 削除
set backspace=indent,eol,start  " BS で indent,改行,挿入開始前を削除
set smarttab        " BS でインデント幅を削除

"""キーマップ（プラグイン固有のキーマップは下のほうに）
" USKeyboard対策
nnoremap ; :
nnoremap : ;

" esc
noremap <C-j> <esc>
noremap! <C-j> <esc>

" .vimrcを開く$MYVIMRCは~/.vimrcに関する環境変数
nnoremap <Leader>v  :<C-u>edit $MYVIMRC<CR>
" source ~/.vimrc を実行する。
nnoremap <Leader>s  :<C-u>source $MYVIMRC<CR>
" ヘルプを右側に縦分割して開く
nnoremap <Leader>h :<C-u>vert bel h<Space>

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

nnoremap <space> za " スペースで折りたたみ解除

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
set noshowmatch       " 括弧入力で対応する括弧を一瞬強調
set noundofile      " undofileを保存しない
let loaded_matchparen = 1

""" クリップボード
" vim --version | grep clipboardで+clipboardの場合
set clipboard=unnamed,autoselect

" -clipboardの場合 xselをインストールして下記キーマップ設定
vmap <C-c> :w !xsel -ib<CR><CR>

""" template
"autocmd BufNewFile *.py 0r ~/.vim/template/python.txt

""" Function
""" create directory automatically 存在しないディレクトリ作成
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

" カレントディレクトリ設定(自動的に開いたファイルのディレクトリに移動)
" if exists('+autochdir')
    " set autochdir
" endif

" 全角スペースを　ハイライト表示させる
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

""" Config for Plugin
""" NERDTree
" let file_name = expand("%")
" if has('vim_starting') &&  file_name == ""
    " autocmd VimEnter * NERDTree ./
" endif
let NERDTreeShowHidden = 1
""" neでトグル
noremap ne :NERDTreeToggle<CR>

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

""" Beffet.vim
nnoremap <silent> ,, :Bufferlist<CR>

""" Config for Jedi.vim
let g:jedi#documentation_command = "<leader>j"
" let g:jedi#show_function_definition = "0"
let g:jedi#popup_on_dot = 0

""" <TAB>: completion
let g:neocomplcache_enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Jscomplete as neco plugin
autocmd FileType javascript,coffee setlocal omnifunc=javascriptcomplete#CompleteJS
let g:neocomplcache_source_rank = {
  \ 'jscomplete' : 500,
  \ }
" dom も含める
let g:jscomplete_use = ['dom']

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" スニペットファイルの配置場所
let g:neosnippet#disable_runtime_snippets = {
\   '_' : 1,
\ }
" let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/plugged/vim-snippets/snippets'


" for gist-vim
if has("unix")
    let g:gist_clip_command = 'xclip -selection clipboard'
elseif has("mac")
    let g:gist_clip_command = 'pbcopy'
endif
let g:gist_update_on_write = 2

" vimshell
let g:vimshell_prompt_expr = 'getcwd()." > "'
let g:vimshell_prompt_pattern = '^\f\+ > '
nnoremap <Space>vs :VimShell<CR>
nnoremap <Space>vp :VimShellPop<CR>

" nginx.vim
au BufRead,BufNewFile /etc/nginx/* set ft=nginx

" lightline.vim
let g:lightline = {
            \ 'colorscheme': 'solarized',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'filename', 'modified' ],
            \             [ 'fugitive' ]
            \            ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'filetype', 'fileencoding', 'fileformat' ] ]
            \   },
            \ 'component': {
            \   'fugitive': '%{exists("*fugitive#statusline()")?fugitive#statusline():""}'
            \   }
            \ }

" Vim-Plug
nnoremap <silent><Space>pu :PlugUpdate<cr>
nnoremap <silent><Space>pg :PlugUpgrade<cr>
" Arpeggio
" call arpeggio#load()
" let g:arpeggio_timeoutlen = 70
" Arpeggio inoremap jk <Esc>
