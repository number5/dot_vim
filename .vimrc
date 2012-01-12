set nocompatible

filetype off
call pathogen#infect() 

filetype on
filetype plugin on
syntax on

" colorscheme wombat256mod
colorscheme mango
"colorscheme solarized
set bg=dark

" set autochdir  " disabled for command-T
set backspace=indent,eol,start
set cmdheight=2 " Statusbar
set completeopt-=preview
set colorcolumn=80
set enc=utf-8
set expandtab
"set digraph " causing trouble while coding
set gdefault
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
set showbreak=↪\ \  
set showcmd
set showmatch
set smartindent " Set Better Indention
set smarttab
set softtabstop=4
set statusline=%F%m%r%h%w\ [%Y\ %{&ff}]%=[%l/%L,\ col\ %c\ (%p%%)]
set switchbuf=useopen
set t_Co=256
set tabstop=4
set title
set ttyfast
set virtualedit=all
set wildmenu         " make tab completion for files/buffers act like bash
set wildmode=list:full " show a list when pressing tab and complete
                       " first full match
set wrap
set cpo&vim " for neocomplcache

let mapleader = ','
let localmapleader = ',' 

" map ; to :
nnoremap ; :

" Avoid accidental hits of <F1> while aiming for <Esc>
map! <F1> <Esc>


" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

let g:ackprg="ack-grep -H --nocolor --nogroup --column"
let g:pydiction_location = '~/.vim/pydiction/complete-dict'

" Tagbar
let g:tagbar_left = 1
let g:tagbar_expand = 1
let g:tagbar_width = 30
let g:tagbar_autofocus = 1

nnoremap <silent> <C-l> :TagbarToggle<CR>


" yankring config
let g:yankring_history_dir = '$HOME/.var'
nnoremap <leader>r  :YRShow<CR>

" bufExplorer
let g:bufExplorerShowRelativePath=1  " Show relative paths.
nmap <script> <silent><C-b> :BufExplorer<CR>

" pydiction
set iskeyword+=.

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python  set tabstop=4 textwidth=79

au BufNewFile,BufRead *.jinja set syntax=jinja
au BufNewFile,BufRead *.xhtml set syntax=jinja
au BufNewFile,BufRead *.html set syntax=jinja
au BufNewFile,BufRead *.hbs set syntax=jinja
au BufNewFile,BufRead *.mako set ft=mako
au BufNewFile,BufRead *.tac set ft=python
au BufNewFile,BufRead Vagrantfile set ft=ruby
au BufNewFile,BufRead *.pp set ft=ruby
au BufNewFile,BufRead *.hosts set ft=dns

au BufNewFile,BufRead *.wiki set sw=2
au BufNewFile,BufRead /etc/nginx/* set ft=nginx " we need this because modeline is disabled for root
au FileType javascript set makeprg=jshint\ %

" key mapping
" Titlise Visually Selected Text (map for .vimrc)
vmap ,c :s/\<\(.\)\(\k*\)\>/\u\1\L\2/g<CR>



noremap <C-left> :bprev<CR>
noremap <C-right> :bnext<CR> 

noremap <silent> <leader>y "+y
noremap <silent> <leader>p i<C-r>+


nmap <silent><leader>/ :nohlsearch<CR>

" Run Ack fast (mind the trailing space here, wouldya?)
nnoremap <leader>a :LAck 

" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" shortcut to jump to next conflict marker
nmap <silent><leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>

" indent/unindent code
vmap <A-]> >gv
vmap <A-[> <gv

" neocomplcache
" Disable AutoComplPop. 
let g:acp_enableAtStartup = 0 
" Use neocomplcache. 
let g:neocomplcache_enable_at_startup = 1 
" Use smartcase. 
let g:neocomplcache_enable_smart_case = 1 

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand) 

"Recommended key-mappings
imap <silent><expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>" 
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>" 
inoremap <expr><C-y>  neocomplcache#close_popup() 
inoremap <expr><C-e>  neocomplcache#cancel_popup() 
" end of neocomplcache settings

" quicker window switching
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap <Down> gj
nnoremap k gk
nnoremap <Up> gk

" tab for brackets
nnoremap <tab> %
vnoremap <tab> %

"syntastic 
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1

" Unite / quick fix
nnoremap <leader>q :Unite qf<CR>
nnoremap <leader>j :Unite jump<CR>

" Command-T support
nnoremap <leader>o :CommandT<CR>
nnoremap <leader>e :CommandT <C-R>=expand("%:p:h") . "/"<CR>
set wildignore+=*.o,*.obj,.git,*.pyc
set noequalalways
let g:CommandTMaxHeight=20
let g:CommandTMatchWindowAtTop=1

" NerdTree
nnoremap <leader>[ :NERDTree<CR>
let g:NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']
let g:NERDTreeHijackNetrw=1

" vimwiki
nnoremap <Leader>t :e ~/vimwiki/TODO.wiki<CR>
nnoremap <Leader>d :VimwikiMakeDiaryNote<CR>
nnoremap <A-x> :VimwikiToggleListItem<CR>
let g:vimwiki_fold_lists = 1

" super powerful spells here
cmap >fn <c-r>=expand('%:p')<cr>
cmap >fd <c-r>=expand('%:p:h').'/'<cr>
cmap w!! w !sudo tee % >/dev/null

imap <F3> <C-R>=strftime("%x %r")<CR>

" vim-virtualenv
let g:virtualenv_directory = "/home/bwang/work/"

" paste
nnoremap <silent> <F5> :set paste!<bar>set paste?<CR>
set pastetoggle=<F5>

" Edit the vimrc file
"nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"autocmd BufWritePost *.js silent JSHint | cwindow
" CoffeeScript
autocmd BufWritePost *.coffee silent CoffeeMake! | cwindow
let g:coffee_make_options = ""

let g:tagbar_type_coffee = {
  \ 'kinds' : [
  \   'f:functions',
  \   'o:object'
  \ ],
  \ 'kind2scope' : {
  \  'f' : 'object',
  \   'o' : 'object'
  \},
  \ 'sro' : ".",
  \ 'ctagsbin' : 'coffeetags',
  \ 'ctagsargs' : '--include-vars --f -',
  \}
