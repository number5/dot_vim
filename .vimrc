set nocompatible

filetype off
call pathogen#runtime_append_all_bundles() 
call pathogen#helptags()

filetype on
filetype plugin on
syntax on

" colorscheme torte
colorscheme wombat256mod

set autochdir
set backspace=indent,eol,start
set cmdheight=2 " Statusbar
set completeopt-=preview
set enc=utf-8
set smarttab
set expandtab
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set linebreak
set lz " do not redraw while running macros (much faster) 
set nobackup " Disable Generation of Backup Files
set noswapfile
set novisualbell
set number
set ruler
set scrolloff=7
set shiftwidth=4
set showbreak=...\  
set showcmd
set showmatch
set smartindent " Set Better Indention
set statusline=%F%m%r%h%w\ [%Y\ %{&ff}]\ [%l/%L,%c\ (%p%%)]
set switchbuf=useopen
set title
set t_Co=256
set tabstop=4
set softtabstop=4
set wrap
set wildmenu         " make tab completion for files/buffers act like bash
set wildmode=list:full          " show a list when pressing tab and complete
                                "    first full match
let mapleader = ','
let localmapleader = ',' 

" map ; to :
nnoremap ; :

" Avoid accidental hits of <F1> while aiming for <Esc>
map! <F1> <Esc>

" CommandT
" nmap <leader>t :CommandT<CR>
set wildignore+=*.o,*.obj,.git,*.pyc

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

let g:ackprg="ack-grep -H --nocolor --nogroup --column"
let g:pydiction_location = '~/.vim/pydiction/complete-dict'

" TagList Plugin Configuration

let Tlist_Ctags_Cmd='/usr/bin/ctags' " point taglist to ctags
let Tlist_GainFocus_On_ToggleOpen = 1 " Focus on the taglist when its toggled more
let Tlist_Exit_OnlyWindow = 1     " exit if taglist is last window open
let Tlist_Show_One_File = 1       " Only show tags for current buffer
let Tlist_Inc_Winwidth = 0 " no window resize 
let Tlist_Close_On_Select = 1 " Close when something's selected
let Tlist_File_Fold_Auto_Close = 1 " Close folds for inactive files 

" yankring config
let g:yankring_history_dir = '$HOME/.var'
nnoremap <F11>  :YRShow<CR>

" bufExplorer
let g:bufExplorerShowRelativePath=1  " Show relative paths.

" pydiction
set iskeyword+=.

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako
au BufNewFile,BufRead *.tac set ft=python
au BufNewFile,BufRead Vagrantfile set ft=ruby
au BufNewFile,BufRead *.wiki set sw=2

" key mapping

" wicked mapping
" Titlise Visually Selected Text (map for .vimrc)
vmap ,c :s/\<\(.\)\(\k*\)\>/\u\1\L\2/g<CR>

nmap <silent> <C-l> :TlistToggle<CR>
nmap <script> <silent>  :BufExplorer<CR>


noremap <C-left> :bprev<CR>
noremap <C-right> :bnext<CR> 

noremap <silent> <C-y> "+y
noremap <silent> <C-p> "+p

" => Fuzzy finder
noremap  <silent> <leader>f :FufFileWithCurrentBufferDir<CR>
noremap  <silent> <leader>b :FufBuffer<CR>
noremap  <silent> <leader>q :FufQuickfix<CR>

nmap <silent><leader>/ :nohlsearch<CR>

" Run Ack fast (mind the trailing space here, wouldya?)
nnoremap <leader>a :LAck 

" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" shortcut to jump to next conflict marker
nmap <silent><leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>


" neocomplcache
" Disable AutoComplPop. 
let g:acp_enableAtStartup = 0 
" Use neocomplcache. 
let g:neocomplcache_enable_at_startup = 1 
" Use smartcase. 
let g:neocomplcache_enable_smart_case = 1 
" Recommended key-mappings. 
imap <silent><expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
" <CR>: close popup and save indent. 
"inoremap <expr><CR>  neocomplcache#smart_close_popup() 
" <TAB>: completion. 
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>" 
" <C-h>, <BS>: close popup and delete backword char. 
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>" 
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>" 
inoremap <expr><C-y>  neocomplcache#close_popup() 
inoremap <expr><C-e>  neocomplcache#cancel_popup() 

" vimwiki
:map <Leader>d <Plug>VimwikiMakeDiaryNote
:map <leader><Space> <Plug>VimwikiToggleListItem
let g:vimwiki_fold_lists = 1

