let g:python3_host_prog = '/usr/local/bin/python3'
"let g:loaded_python_provider = 1 

call plug#begin('~/.config/nvim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'felixjung/vim-base16-lightline'
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'

Plug 'itchyny/lightline.vim' " {{{
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction'],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo'],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'readonly': 'MyReadonly',
      \   'modified': 'MyModified',
      \ },
      \ 'separator': { 'right': '', 'left': '' },
      \ 'subseparator': { 'right': '', 'left': '' }
      \ }

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

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

Plug 'wincent/ferret' " {{{
" }}}


Plug 'Shougo/echodoc.vim'

" Languages
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-sources', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'} 
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'} 
Plug 'liuchengxu/vista.vim'

Plug 'dense-analysis/ale'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'tpope/vim-ragtag'
Plug 'mattn/emmet-vim'
 
Plug 'saltstack/salt-vim'
Plug 'towolf/vim-helm'

"Plug 'hashivim/vim-hashicorp-tools'
Plug '$HOME/src/git/vim-hashicorp-tools'
" {{{ Elixir
Plug 'powerman/vim-plugin-AnsiEsc'
"}}}
"
Plug 'chr4/nginx.vim'
Plug 'tpope/vim-abolish'
Plug 'majutsushi/tagbar'

" clojure
Plug 'tpope/vim-classpath'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'jbnicolai/rainbow_parentheses.vim'
Plug 'eraserhd/parinfer-rust', {'do':
        \  'cargo build --manifest-path=cparinfer/Cargo.toml --release'}

Plug 'Yggdroot/indentLine'
"{{
let g:indentLine_char = '┆'
"}}
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

Plug 'junegunn/vim-slash' " {{{
noremap <plug>(slash-after) zz
"}}}

Plug 'osyo-manga/vim-over' " {{{
  let g:over_command_line_prompt = ':'
  let g:over_enable_cmd_window = 1
  let g:over#command_line#search#enable_incsearch = 1
  let g:over#command_line#search#enable_move_cursor = 1

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

set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf.vim'
" {{{
  let  g:fzf_nvim_statusline = 0
  let g:fzf_layout = { 'left': '~40%' } 
" }}}

Plug 'hecal3/vim-leader-guide'
Plug 'mhinz/vim-startify'

" NV {{
Plug 'Alok/notational-fzf-vim'
let g:nv_search_paths = [ '~/learn/knowledge/', '~/learn/blog/contents']
let g:nv_default_extension = '.md'
"}}

Plug 'chrisbra/unicode.vim'

" mergetool {{
Plug 'samoshkin/vim-mergetool'
let g:mergetool_layout = 'mr'
let g:mergetool_prefer_revision = 'local'
" }}

call plug#end()

" polyglot

filetype on
filetype plugin on
filetype indent on
syntax on
compiler ruby

colorscheme onedark
"colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
"colorscheme dracula
"colorscheme base16-twilight
set bg=dark
let g:solarized_termcolors=256

set autoindent
set backspace=indent,eol,start
set cmdheight=2 " Statusbar
set colorcolumn=80
set expandtab
set gdefault
set hidden
set history=1000
set hlsearch
set ignorecase
"set incsearch
set inccommand=nosplit
set laststatus=2
set linebreak
set lz " do not redraw while running macros (much faster) 
set nobackup " Disable Generation of Backup Files
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

" If rg is available use it as filename list generator instead of 'find'
set grepprg=rg\ --vimgrep


" Tagbar
let g:tagbar_left = 1
let g:tagbar_expand = 1
let g:tagbar_width = 30
let g:tagbar_autofocus = 1

nnoremap <silent> <C-l> :TagbarToggle<CR>


" yankstack config
nnoremap <leader>r  :Yanks<CR>

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python  set tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

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
au Filetype lua setlocal ts=2 sts=2 sw=2
au BufNewFile,BufRead *.wiki set sw=2
"au BufNewFile,BufRead /etc/nginx/* set ft=nginx " we need this because modeline is disabled for root
augroup filetypedetect
  " nginx, from nginx.vim in chr4/nginx.vim
au BufRead,BufNewFile *.nginx set ft=nginx
au BufRead,BufNewFile nginx*.conf set ft=nginx
au BufRead,BufNewFile *nginx.conf set ft=nginx
au BufRead,BufNewFile */etc/nginx/*.conf set ft=nginx
au BufRead,BufNewFile */usr/local/nginx/conf/*.conf set ft=nginx
augroup end 

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


" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif


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

" mappings for fzf 
nnoremap <silent> <C-B> :Buffers<Cr>
nnoremap <silent> <leader>e :Files<Cr>

" ferret 
nmap <leader>z <Plug>(FerretAckWord)

" no auto folding
set nofoldenable
set foldmethod=indent
set foldminlines=2

set termguicolors   
set cursorline
