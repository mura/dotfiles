"-----------------------------------------------------------------------------
" 文字コード関連
"
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,iso-2022-jp

"-----------------------------------------------------------------------------
" dein.vim
"
if &compatible
  set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
let g:loaded_python_provider = 0
let g:python3_host_prog = expand('~/venv/nvim/bin/python3')

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  let g:deoplete#enable_at_startup = 1

  call dein#add('jmcantrell/vim-virtualenv')

  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('lifepillar/vim-solarized8')

  call dein#add('tyru/caw.vim')
  call dein#add('leafgarland/typescript-vim')
  call dein#add('vim-jp/vimdoc-ja')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on

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

" vim: set ts=2 sw=4 sts=0 expandtab:
