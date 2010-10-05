set nocompatible
syntax on
" colorscheme torte
colorscheme wombat256mod
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
highlight OverLength ctermbg=red ctermfg=white 
match OverLength /\%81v.\+/

"key mapping
source ~/.vim/key-mapping.vim

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

" => Fuzzy finder
noremap  <silent> <leader>f :FufFileWithFullCwd<CR>
noremap  <silent> <leader>b :FufBuffer<CR>
noremap  <silent> <leader>q :FufQuickfix<CR>

" pydiction
set iskeyword+=.


""""""""""""""""""""""""""""""
" => Python section
" """"""""""""""""""""""""""""""
au FileType python set nocindent
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako
au BufNewFile,BufRead *.tac set ft=python

" wicked mapping
" Titlise Visually Selected Text (map for .vimrc)
vmap ,c :s/\<\(.\)\(\k*\)\>/\u\1\L\2/g<CR>
