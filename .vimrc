set nocompatible
syntax on
" colorscheme torte
colorscheme wombat256mod
set t_Co=256
set lz " do not redraw while running macros (much faster) 
set nobackup " Disable Generation of Backup Files
set noswapfile
set ruler
set completeopt-=preview
set linebreak
set wrap
set novisualbell
set smartindent " Set Better Indention
set cmdheight=2 " Statusbar
set laststatus=2
set statusline=%F%m%r%h%w\ [%Y\ %{&ff}]\ [%l/%L,%c\ (%p%%)]
set number
set autochdir
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

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
 
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

call pathogen#runtime_append_all_bundles() 
call pathogen#helptags()

filetype off
filetype on
filetype plugin on


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

" pydiction
set iskeyword+=.

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako
au BufNewFile,BufRead *.tac set ft=python

" key mapping

" wicked mapping
" Titlise Visually Selected Text (map for .vimrc)
vmap ,c :s/\<\(.\)\(\k*\)\>/\u\1\L\2/g<CR>

nmap <silent> <C-l> :TlistToggle<CR>
nmap <script> <silent>  :BufExplorer<CR>

let mapleader = ','
let localmapleader = ',' 

noremap <C-left> :bprev<CR>
noremap <C-right> :bnext<CR> 

noremap <silent> <C-y> "+y
noremap <silent> <C-p> "+p

" => Fuzzy finder
noremap  <silent> <leader>f :FufFileWithCurrentBufferDir<CR>
noremap  <silent> <leader>b :FufBuffer<CR>
noremap  <silent> <leader>q :FufQuickfix<CR>

