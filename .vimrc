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

if dein#load_state(expand('~/.cache/dein'))
  call dein#begin(expand('~/.cache/dein'))

  call dein#add('Shougo/dein.vim')

  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/neosnippet')

  call dein#add('vim-jp/vimdoc-ja')
  "call dein#add('itchyny/lightline.vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('tyru/caw.vim.git')
  call dein#add('leafgarland/typescript-vim')

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
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
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
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1

"-----------------------------------------------------------------------------
"
"
map <Esc>[1~ <Home>
map <Esc>[2~ <Insert>
map <Esc>[3~ <Delete>
map <Esc>[4~ <End>
map <Esc>[5~ <PageUp>
map <Esc>[6~ <PageDown>
map! <Esc>[1~ <Home>
map! <Esc>[2~ <Insert>
map! <Esc>[3~ <Delete>
map! <Esc>[4~ <End>
map! <Esc>[5~ <PageUp>
map! <Esc>[6~ <PageDown>

nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" vim: set ts=2 sw=4 sts=0 expandtab:
