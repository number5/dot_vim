set nocompatible

filetype off
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect() 
call pathogen#helptags()

filetype on
filetype plugin on
filetype indent on
syntax on
compiler ruby

set bg=dark
colorscheme jellybeans
let g:solarized_termcolors=256

set autoindent
set backspace=indent,eol,start
set cmdheight=2 " Statusbar
set completeopt-=preview
set colorcolumn=80
set enc=utf-8
set expandtab
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
set noballooneval
set noswapfile
set novisualbell
set number
set ruler
set scrolloff=7
set shiftwidth=4  " set default to 4, need set to 2 for ruby type
set showbreak=↪\ \  
set showcmd
set showmatch
set smartindent " Set Better Indention
set smarttab
set splitbelow
set splitright

" status line settings, stole from
" https://github.com/millermedeiros/vim-statline/blob/master/plugin/statline.vim 
"set statusline=%F%m%r%h%w\ [%Y\ %{&ff}]%=[%l/%L,\ col\ %c\ (%p%%)]
hi link User1 Title
hi link User2 DiffChange
hi link User3 Comment
hi link User4 Keyword
hi link User5 Type
hi link User6 WarningMsg
set statusline=
set statusline +=%2*\ %y%*              "file type
set statusline +=%1*\ %<%f\ %*          "full path
set statusline +=%6*%{&paste?'PASTE':''}%*
set statusline +=%2*%m%r%h%*            "modified/readonly/help flag
set statusline +=%3*%=%{&ff}/%{&fenc}%*  "file format
set statusline +=%5*\ %5l%*             "current line
set statusline +=%4*/%L,%*            "total lines
set statusline +=%5*%3c\ %*         "column number
set statusline +=%4*(%p%%)\ %*          "percentage 


set switchbuf=useopen
set t_Co=256
set title
set ttyfast
set virtualedit=all
set wildmenu         " make tab completion for files/buffers act like bash
set wildmode=list:full " show a list when pressing tab and complete
                       " first full match
set nowrap
set cpo&vim " for neocomplcache
set secure

" for ruby
set cf   " confirm

" for textobject-rubyblock
runtime macros/matchit.vim 


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

let g:ackprg="ag --nocolor --nogroup --column"

" Tagbar
let g:tagbar_left = 1
let g:tagbar_expand = 1
let g:tagbar_width = 30
let g:tagbar_autofocus = 1

nnoremap <silent> <C-l> :TagbarToggle<CR>


" yankstack config
nnoremap <leader>r  :Yanks<CR>
set macmeta

" bufExplorer
let g:bufExplorerShowRelativePath=1  " Show relative paths.
nmap <script> <silent><C-b> :BufExplorer<CR>

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python  set tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79

au BufNewFile,BufRead *.jinja set syntax=jinja
au BufNewFile,BufRead *.xhtml set syntax=jinja
au BufNewFile,BufRead *.html set syntax=jinja
au BufNewFile,BufRead *.hbs set syntax=jinja
au BufNewFile,BufRead *.handlebars set syntax=jinja
au BufNewFile,BufRead *.mako set ft=mako
au BufNewFile,BufRead *.tac set ft=python
au BufNewFile,BufRead Vagrantfile set ft=ruby
au BufNewFile,BufRead *.pp set ft=ruby
au BufNewFile,BufRead *.hosts set ft=dns
au Filetype html setlocal ts=2 sts=2 sw=2
au Filetype ruby setlocal ts=2 sts=2 sw=2
au BufNewFile,BufRead *.wiki set sw=2
au BufNewFile,BufRead /etc/nginx/* set ft=nginx " we need this because modeline is disabled for root
au FileType javascript set makeprg=jshint\ %

" key mapping
" Titlise Visually Selected Text (map for .vimrc)
vmap <leader>c :s/\<\(.\)\(\k*\)\>/\u\1\L\2/g<CR>

noremap <D-Left> :bprev<CR>
noremap <D-Right> :bnext<CR> 

noremap <silent> <leader>y "+y
noremap <silent> <leader>p i<C-r>+


nmap <silent><leader>/ :nohlsearch<CR>

" Run Ack fast (mind the trailing space here, wouldya?)
nnoremap <leader>a :LAck 

" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" indent/unindent code
vmap <A-]> >gv
vmap <A-[> <gv

" neocomplete.vim
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion. (Used neosnippet's version instead)
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" end of neocomplete.vim settings

" quicker window switching
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap <Down> gj
nnoremap k gk
nnoremap <Up> gk


" Unite / quick fix
nnoremap <leader>j :Unite jump<CR>

" CtrlP support
let g:ctrlp_map = '<S_F8>'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_max_files = 5000
nnoremap <leader>q :CtrlPQuickfix<CR>
nnoremap <leader>o :CtrlPMixed<CR>
nnoremap <leader>e :CtrlP <C-R>=expand("%:p:h") . "/"<CR>
set wildignore+=*.o,*.obj,.git,*.pyc
set noequalalways

" NerdTree
nnoremap <leader>[ :NERDTree<CR>
let g:NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']
let g:NERDTreeHijackNetrw=1


" super powerful spells here
cmap >fn <c-r>=expand('%:p')<cr>
cmap >fd <c-r>=expand('%:p:h').'/'<cr>
cmap w!! w !sudo tee % >/dev/null
"cmap W w

imap <F3> <C-R>=strftime("%x %r")<CR>


" paste
nnoremap <silent> <F5> :set paste!<bar>set paste?<CR>
set pastetoggle=<F5>

" Edit the vimrc file
nmap <silent> <leader>sv :so $MYVIMRC<CR>

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

" indent guides
let g:indent_guides_auto_colors = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=010
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey

"

if has("gui_running")

    " GUI only config
    set completeopt-=preview
    "set guifont=Droid\ Sans\ Mono\ Slashed\ 13
    "set guifont=Inconsolata\ Medium\ 15
    set guifont=Source\ Code\ Pro:h15
    set lines=40 columns=85

    set langmenu=en_US.utf-8
    language mes en_US.UTF-8
    set guioptions+=c
    set guioptions-=e
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R

    set bg=light
    "colorscheme solarized
    colorscheme jellybeans
    let g:solarized_termcolors=256
    let g:solarized_bold = 1
    let g:solarized_underline = 1
    let g:solarized_italic = 1
    "let g:solarized_contrast = "high"
endif

" EOF
