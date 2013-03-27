set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

""" Vundle自身
Bundle 'gmarik/vundle'

""" ヘルプ
Bundle 'vim-jp/vimdoc-ja'
Bundle 'thinca/vim-ref'

""" カラースキーム
Bundle 'altercation/vim-colors-solarized'

""" ステータスライン
Bundle 'Lokaltog/vim-powerline'

""" ファイラー・バッファ管理
Bundle 'scrooloose/nerdtree'
Bundle 'Shougo/unite.vim'
Bundle 'sandeepcr529/Buffet.vim'

""" 文字コード自動判定
Bundle 'banyan/recognize_charcode.vim'

""" テンプレート
Bundle 'mattn/sonictemplate-vim'
Bundle 'Shougo/neosnippet'

""" 辞書
Bundle 'koron/dicwin-vim'

""" 開発支援
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'davidhalter/jedi-vim'
Bundle 'mitechie/pyflakes-pathogen'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'Shougo/vimproc'
Bundle 'thinca/vim-quickrun'
Bundle 'scrooloose/nerdcommenter'

""" ユーティリティ
Bundle 'sudo.vim'
Bundle 'Shougo/vimshell'
Bundle 'Shougo/neocomplcache'

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
""" 削除
set backspace=indent,eol,start  " BS で indent,改行,挿入開始前を削除
set smarttab        " BS でインデント幅を削除

"""キーマップ（プラグイン固有のキーマップは下のほうに）
" USKeyboard対策
nnoremap ; :
nnoremap : ;
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
nnoremap <silent><Leader>l :Bufferlist<CR>

""" Config for Vim-ref
"" Config for Ref webdict
" URL http://www.karakaram.com/20120726-vim-ref
" URL2 http://www.karakaram.com/ref-webdict
" ヴィジュアルモード等でヤンクした単語をコマンドラインモード
" にペースト C-R + "

let g:ref_source_webdict_sites = {
\   'je': {
\     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
\   },
\   'ej': {
\     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
\   },
\   'wiki': {
\     'url': 'http://ja.wikipedia.org/wiki/%s',
\   },
\ }

" デフォルトサイト
let g:ref_source_webdict_sites.default = 'ej'

" 出力に対するフィルタ。最初の数行を削除
function! g:ref_source_webdict_sites.je.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ej.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.wiki.filter(output)
  return join(split(a:output, "\n")[17 :], "\n")
endfunction

nnoremap <Leader>e :<C-u>Ref webdict ej<Space>

""" Config for Jedi.vim
let g:jedi#pydoc = "<leader>d"

""" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" スニペットファイルの配置場所
let g:NeoComplCache_SnippetsDir = '~/.vim/snippets'
