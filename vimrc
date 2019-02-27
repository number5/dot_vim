set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'chriskempson/base16-vim'
Plug 'altercation/solarized', { 'rtp': 'vim-colors-solarized'}
Plug 'goatslacker/mango.vim'

Plug 'felixjung/vim-base16-lightline'
Plug 'itchyny/lightline.vim' " {{{
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo', 'syntastic' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component_function': {
      \   'readonly': 'MyReadonly',
      \   'modified': 'MyModified',
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'separator': { 'right': '', 'left': '' },
      \ 'subseparator': { 'right': '', 'left': '' }
      \ }

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return " "
  else
    return ""
  endif
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%') ? expand('%') : '[NoName]')
endfunction

function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction
" }}}


Plug 'vim-scripts/gitignore'

" CtrlP
Plug 'ctrlpvim/ctrlp.vim' | Plug 'tacahiroy/ctrlp-funky' | Plug 'd11wtq/ctrlp_bdelete.vim' | Plug 'FelikZ/ctrlp-py-matcher'


Plug 'wincent/ferret' " {{{
    nmap <leader>z <Plug>(FerretAckWord)
" }}}

Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" Neocomplete
Plug 'Konfekt/FastFold'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet' | Plug 'Shougo/neosnippet-snippets' | Plug 'honza/vim-snippets'

" Languages
Plug 'https://github.com/sheerun/vim-polyglot.git'
Plug 'tpope/vim-ragtag'
Plug 'walm/jshint.vim'
Plug 'othree/yajs.vim'
Plug 'mattn/emmet-vim'
 
Plug 'saltstack/salt-vim'
Plug 'hynek/vim-python-pep8-indent'
Plug 'avakhov/vim-yaml'
Plug 'b4b4r07/vim-hcl'
" {{{ Elixir
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'slashmili/alchemist.vim'
"}}}

Plug 'scrooloose/syntastic'

Plug 'tpope/vim-abolish'
Plug 'majutsushi/tagbar'

" clojure
Plug 'tpope/vim-classpath'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'jbnicolai/rainbow_parentheses.vim'


Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-jdaddy' "Json quick movements
Plug 'nvie/vim-rst-tables'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-surround'

Plug 'wellle/targets.vim'
Plug 'bps/vim-textobj-python'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'kana/vim-textobj-user'
Plug 'terryma/vim-expand-region' " {{{
" vim expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" }}} 

Plug 'maxbrunsfeld/vim-yankstack'

Plug 'tpope/vim-sensible'


" {{{ searching
Plug 'justinmk/vim-sneak' " {{{
  let g:sneak#prompt = '(sneak)» '
  map <silent> f <Plug>Sneak_f
  map <silent> F <Plug>Sneak_F
  map <silent> t <Plug>Sneak_t
  map <silent> T <Plug>Sneak_T
  map <silent> ; <Plug>SneakNext
  map <silent> , <Plug>SneakPrevious
  augroup SneakPlugincolors
    autocmd!
    autocmd ColorScheme * hi SneakPluginTarget
    \ guifg=black guibg=red ctermfg=black ctermbg=red
    autocmd ColorScheme * hi SneakPluginScope
    \ guifg=black guibg=yellow ctermfg=black ctermbg=yellow
  augroup END
" }}}

Plug 'haya14busa/incsearch.vim' " {{{
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)
  let g:incsearch#consistent_n_direction = 1
  let g:incsearch#auto_nohlsearch = 1
  let g:incsearch#magic = '\v'
" }}}

Plug 'osyo-manga/vim-over' " {{{
  let g:over_command_line_prompt = ':'
  let g:over_enable_cmd_window = 1
  let g:over#command_line#search#enable_incsearch = 1
  let g:over#command_line#search#enable_move_cursor = 1
  " Use vim-over instead of builtin substitution
  " http://leafcage.hateblo.jp/entry/2013/11/23/212838
  cnoreabbrev <silent><expr>s getcmdtype() ==# ':' && getcmdline() =~# '^s'
      \ ? "OverCommandLine<CR><C-u>%s/<C-r>=get([], getchar(0), '')<CR>"
      \ : 's'
  cnoreabbrev <silent><expr>'<,'>s getcmdtype() ==# ':' && getcmdline() =~# "^'<,'>s"
      \ ? "'<,'>OverCommandLine<CR>s/<C-r>=get([], getchar(0), '')<CR>"
      \ : "'<,'>s"
" }}}

Plug 'terryma/vim-multiple-cursors' " {{{
  function! Multiple_cursors_before()
    if exists(':NeoCompleteLock') == 2
      NeoCompleteLock
    endif
    if exists('*SwoopFreezeContext') != 0
        call SwoopFreezeContext()
    endif
  endfunction
  function! Multiple_cursors_after()
    if exists(':NeoCompleteUnlock') == 2
      NeoCompleteUnlock
    endif
    if exists('*SwoopUnFreezeContext') != 0
        call SwoopUnFreezeContext()
    endif
  endfunction
" }}}


Plug 'hecal3/vim-leader-guide'
Plug 'mhinz/vim-startify'
call plug#end()

" polyglot
let g:jsx_ext_required = 1
let g:polyglot_disabled = ['javascript', 'yaml']

filetype on
filetype plugin on
filetype indent on
syntax on
compiler ruby

set bg=dark
colorscheme onedark
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

" set wrap by default
set wrap


set autoread
set switchbuf=useopen
set t_Co=256
set title
set ttyfast
set virtualedit=all
set wildmenu         " make tab completion for files/buffers act like bash
set wildmode=longest,full " show a list when pressing tab and complete
                       " first full match
set cpo&vim " for neocomplcache
set secure
"set noshowmode

" for ruby
set cf   " confirm

" for textobject-rubyblock
runtime macros/matchit.vim 


let mapleader = "\<Space>"
let localmapleader = '\<Space>' 

" map ; to :
nnoremap ; :

nnoremap <Leader>w :w<CR>

" Avoid accidental hits of <F1> while aiming for <Esc>
map! <F1> <Esc>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" CtrlP
" Set delay to prevent extra search
let g:ctrlp_lazy_update = 350

" Set no file limit, we are building a big project
let g:ctrlp_max_files = 0
let g:ctrlp_clear_cache_on_exit = 0
" If ag is available use it as filename list generator instead of 'find'
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
endif

let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Tagbar
let g:tagbar_left = 1
let g:tagbar_expand = 1
let g:tagbar_width = 30
let g:tagbar_autofocus = 1

nnoremap <silent> <C-l> :TagbarToggle<CR>


" yankstack config
nnoremap <leader>r  :Yanks<CR>
set macmeta

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python  set tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79

au BufNewFile,BufRead *.jinja set syntax=jinja
au BufNewFile,BufRead *.xhtml set syntax=jinja
au BufNewFile,BufRead *.html set syntax=jinja
au BufNewFile,BufRead *.hbs set syntax=jinja
au BufNewFile,BufRead *.handlebars set syntax=jinja
au BufNewFile,BufRead *.mako set ft=mako
au BufNewFile,BufRead *.upstart set ft=upstart
au BufNewFile,BufRead Vagrantfile set ft=ruby
au BufNewFile,BufRead *.pp set ft=ruby
au BufNewFile,BufRead *.hosts set ft=dns
au Filetype html setlocal ts=2 sts=2 sw=2
au Filetype ruby setlocal ts=2 sts=2 sw=2
au Filetype mkd setlocal ts=2 sts=2 sw=2  " for Markdown
au BufNewFile,BufRead *.wiki set sw=2
au BufNewFile,BufRead /etc/nginx/* set ft=nginx " we need this because modeline is disabled for root
au FileType javascript set makeprg=jshint\ %

" key mapping
" Titlise Visually Selected Text (map for .vimrc)
vmap <leader>c :s/\<\(.\)\(\k*\)\>/\u\1\L\2/g<CR>

noremap <silent> <leader>y "+y
noremap <silent> <leader>p i<C-r>+

nmap <silent><leader>/ :nohlsearch<CR>

" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" indent/unindent code
vmap <A-]> >gv
vmap <A-[> <gv

" {{{ Neocomplete

let g:neocomplete#force_overwrite_completefunc = 1                              " fixes vim-clojure-static  
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()


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


" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" }}} end of neocomplete.vim settings

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


" CtrlP support

call ctrlp_bdelete#init()
let g:ctrlp_map = '<S_F8>'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_max_files = 5000
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|pyc)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_extensions = ['funky']

nnoremap <leader>q :CtrlPQuickfix<CR>
nnoremap <leader>o :CtrlPMixed<CR>
nnoremap <leader>e :CtrlP <C-R>=expand("%:p:h") . "/"<CR>
nnoremap <C-B> :CtrlPBuffer<Cr>
set noequalalways
set wildignore+=*.pyc


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


" markdown
let g:vim_markdown_initial_foldlevel=3


" rainbow parentheses
au VimEnter *.clj RainbowParenthesesToggle
au Syntax clojure RainbowParenthesesLoadRound
au Syntax clojure RainbowParenthesesLoadSquare
au Syntax clojure RainbowParenthesesLoadBraces

" auto wrap in diff mode
au VimEnter * if &diff | execute 'windo set wrap' | endif

" for weird osx crontab issue
autocmd filetype crontab setlocal nobackup nowritebackup

nnoremap <Leader>fu :CtrlPFunky<Cr>  " ctrlp-funky

" no auto folding
set nofoldenable
set foldmethod=indent
set foldminlines=2


set termguicolors   
set cursorline

if has("gui_running")

    " GUI only config
    set completeopt-=preview
    set guifont=Sauce\ Code\ Powerline\ Light:h15

    "set guifont=Inconsolata\ Medium\ 15
    "set guifont=Source\ Code\ Pro\ Semibold:h15
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

    set bg=dark
    "colorscheme solarized
    "colorscheme jellybeans
    colorscheme onedark
    let g:solarized_termcolors=256
    let g:solarized_bold = 1
    let g:solarized_underline = 1
    let g:solarized_italic = 1
    "let g:solarized_contrast = "high"
endif

" EOF
