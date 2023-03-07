"-----------------------------------------------------------------------------
" dein.vim
"
" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Set Dein base path (required)
let s:dein_base = expand('~/.cache/dein')

" Set Dein source path (required)
let s:dein_src = expand('~/.cache/dein/repos/github.com/Shougo/dein.vim')

" Set Dein runtime path (required)
execute 'set runtimepath+=' . s:dein_src

" Call Dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)

" Your plugins go here:
"call dein#add('Shougo/ddc.vim')
"call dein#add('vim-denops/denops.vim')
call dein#add('jmcantrell/vim-virtualenv')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('lifepillar/vim-solarized8')
call dein#add('tyru/caw.vim')
call dein#add('leafgarland/typescript-vim')

" Finish Dein initialization (required)
call dein#end()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" Uncomment if you want to install not-installed plugins on startup.
if dein#check_install()
 call dein#install()
endif

"-----------------------------------------------------------------------------
" 文字コード関連
"
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,iso-2022-jp

"-----------------------------------------------------------------------------
" 編集関連
"
"オートインデントする
set autoindent
"バックアップをとらない
set nobackup

"-----------------------------------------------------------------------------
" 検索関連
"
"検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
"検索時に最後まで行ったら最初に戻る
set wrapscan
"検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch

"-----------------------------------------------------------------------------
" 装飾関連
"
"シンタックスハイライトを有効にする
syntax enable
"行番号を表示する
set number
"タブの左側にカーソル表示
set listchars=tab:\ \
set list
"タブ幅を設定する
set tabstop=2
set shiftwidth=2
"入力中のコマンドをステータスに表示する
set showcmd
"括弧入力時の対応する括弧を表示
set showmatch
"検索結果文字列のハイライトを有効にする
set hlsearch
"ステータスラインを常に表示
set laststatus=2
"ステータスラインに文字コードと改行文字を表示する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P
"HTML変換時にCSSを使用する
let html_use_css=1
"テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
"Tabに色を付ける
highlight SpecialKey guifg=#333333
"モードラインを有効
set modeline
set modelines=3
"タブをスペースに展開
set expandtab

" airline
set t_Co=256
set termguicolors
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1
" colorscheme
set background=dark
colorscheme solarized8

"vim: set ts=2 sw=2 sts=0 expandtab:
