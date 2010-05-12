set nocompatible
syntax on
colorscheme torte
set lz " do not redraw while running macros (much faster) 
set nobackup " Disable Generation of Backup Files
set noswapfile
filetype on
filetype plugin on
set ruler
set completeopt-=preview
set linebreak
set wrap
set novisualbell
set smartindent " Set Better Indention
set cmdheight=2 " Statusbar
set laststatus=2
set statusline=%F%m%r%h%w\ [%Y\ %{&ff}]\ [%l/%L\ (%p%%)]
set number
set enc=utf-8
set hlsearch
set ignorecase
set incsearch
set tabstop=4
set shiftwidth=4
set expandtab
set showmatch

set rtp+=/home/bruce/src/git/snipmate.vim

let g:pydiction_location = '/home/bruce/.vim/pydiction/complete-dict'

