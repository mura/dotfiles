" vim: set ts=4 sw=4 sts=0:
"-----------------------------------------------------------------------------
" ʸ�������ɴ�Ϣ
"
"source $VIM/encode_japan.vim
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,euc-jp,sjis,iso-2022-jp

"-----------------------------------------------------------------------------
" �Խ���Ϣ
"
"�����ȥ���ǥ�Ȥ���
set autoindent
"�Хå����åפ�Ȥ�ʤ�
set nobackup

"-----------------------------------------------------------------------------
" ������Ϣ
"
"����ʸ���󤬾�ʸ���ξ�����ʸ����ʸ������̤ʤ���������
set ignorecase
"����ʸ�������ʸ�����ޤޤ�Ƥ�����϶��̤��Ƹ�������
set smartcase
"�������˺Ǹ�ޤǹԤä���ǽ�����
set wrapscan
"����ʸ�������ϻ��˽缡�о�ʸ����˥ҥåȤ����ʤ�
set noincsearch

"-----------------------------------------------------------------------------
" ������Ϣ
"
"���󥿥å����ϥ��饤�Ȥ�ͭ���ˤ���
syntax on
"���ֹ��ɽ������
set number
"���֤κ�¦�˥�������ɽ��
set listchars=tab:\ \ 
set list
"�����������ꤹ��
set tabstop=4
set shiftwidth=4
"������Υ��ޥ�ɤ򥹥ơ�������ɽ������
set showcmd
"������ϻ����б������̤�ɽ��
set showmatch
"�������ʸ����Υϥ��饤�Ȥ�ͭ���ˤ���
set hlsearch
"���ơ������饤�����ɽ��
set laststatus=2
"���ơ������饤���ʸ�������ɤȲ���ʸ����ɽ������
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P
"HTML�Ѵ�����CSS����Ѥ���
let html_use_css=1
"�ƥ�����������μ�ư�ޤ��֤������ܸ���б�������
set formatoptions+=mM
"Tab�˿����դ���
highlight SpecialKey guifg=#333333

" Chalice������
"set runtimepath+=$VIM/chalice

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
