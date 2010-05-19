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
set showcmd
set showbreak=...\  

set rtp+=~/src/git/snipmate.vim

let g:pydiction_location = '~/.vim/pydiction/complete-dict'

" TagList Plugin Configuration

let Tlist_Ctags_Cmd='/usr/bin/ctags' " point taglist to ctags
let Tlist_GainFocus_On_ToggleOpen = 1 " Focus on the taglist when its toggled more
let Tlist_Exit_OnlyWindow = 1     " exit if taglist is last window open
let Tlist_Show_One_File = 1       " Only show tags for current buffer
let Tlist_Inc_Winwidth = 0 " no window resize 
let Tlist_Close_On_Select = 1 " Close when something's selected
"let Tlist_Use_Right_Window = 1 " Project uses the left window
let Tlist_File_Fold_Auto_Close = 1 " Close folds for inactive files 

" yankring config

" bufExplorer
let g:bufExplorerShowRelativePath=1  " Show relative paths.

" => Fuzzy finder
try
    call fuf#defineLaunchCommand('FufCWD', 'file', 'fnamemodify(getcwd(), ''%:p:h'')')
    map <leader>t :FufCWD **/<CR>
catch
endtry

" pydiction
set iskeyword+=.


"key mapping
source ~/.vim/key-mapping.vim

