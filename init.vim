let g:python3_host_prog = '/usr/local/bin/python3.8'
"let g:loaded_python_provider = 1

call plug#begin('~/.config/nvim/plugged')
"Plug 'chriskempson/base16-vim'
"Plug 'felixjung/vim-base16-lightline'
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'bluz71/vim-nightfly-guicolors'

Plug 'itchyny/lightline.vim' " {{{
let g:lightline = {
      \ 'colorscheme': 'nightfly',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo'],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component_function': {
      \   'readonly': 'MyReadonly',
      \   'modified': 'MyModified',
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

Plug 'wincent/ferret' " {{{
" }}}


Plug 'Shougo/echodoc.vim'

" Languages

Plug 'nvim-treesitter/nvim-treesitter'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Extensions to built-in LSP, for example, providing type inlay hints
"Plug 'tjdevries/lsp_extensions.nvim'

" Autocompletion framework for built-in LSP
"Plug 'nvim-lua/completion-nvim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
Plug 'Shougo/deoplete-lsp'
Plug 'Shougo/neco-syntax'

" Diagnostic navigation and settings for built-in LSP
Plug 'nvim-lua/diagnostic-nvim'

Plug 'liuchengxu/vista.vim'

Plug 'dense-analysis/ale' "{{
  let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \}
  let g:ale_linters = {
  \   'terraform': ['terraform'],
  \}

  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
  let g:ale_sign_error = '✘'
  let g:ale_sign_warning = '⚠'
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_close_preview_on_insert = 1
  let g:ale_fix_on_save = 1
  "let g:ale_lint_on_text_changed = "Always"
"}}

Plug 'maximbaz/lightline-ale'

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
Plug 'LokiChaos/vim-tintin'
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
        \  'cargo build --release'}

Plug 'Yggdroot/indentLine'
"{{
let g:indentLine_char_list = ['▏', '¦', '┆', '┊']
let g:indentLine_setColors = 0
let g:indentLine_setConceal = 0                         " actually fix the annoying markdown links conversion
let g:indentLine_fileTypeExclude = ['startify']
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

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " fzf itself
Plug 'junegunn/fzf.vim'
" {{{
  let  g:fzf_nvim_statusline = 0
  let g:fzf_layout = { 'left': '~40%' }
" }}}

Plug 'hecal3/vim-leader-guide'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-signify'

" NV {{
Plug 'Alok/notational-fzf-vim'
let g:nv_search_paths = [ '~/learn/knowledge/', '~/learn/blog/contents']
let g:nv_default_extension = '.md'
"}}

Plug 'chrisbra/unicode.vim'
"Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" mergetool {{
Plug 'samoshkin/vim-mergetool'
let g:mergetool_layout = 'mr'
let g:mergetool_prefer_revision = 'local'
" }}
Plug 'Olical/conjure', {'tag': 'v4.7.0'}

Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} "{{
let g:semshi#error_sign	= v:false
" }}

call plug#end()

filetype on
filetype plugin on
filetype indent on
syntax on
compiler ruby

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c


" Configure lsp
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'nvim_lsp'

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
    -- require'completion'.on_attach(client)
    require'diagnostic'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })
nvim_lsp.jedi_language_server.setup({on_attach=on_attach})
nvim_lsp.sumneko_lua.setup({on_attach=on_attach})
nvim_lsp.terraformls.setup({
                on_attach=on_attach,
                cmd = {'terraform-ls', 'serve'}
                })

EOF

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" Trigger completion with <tab>
" found in :help completion
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()

" Visualize diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_trimmed_virtual_text = '40'
" Don't show diagnostics while in insert mode
let g:diagnostic_insert_delay = 1

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=3200
" Show diagnostic popup on cursor hover
autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>PrevDiagnosticCycle<cr>
nnoremap <silent> g] <cmd>NextDiagnosticCycle<cr>

" Enable type inlay hints
"autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
"\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }

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
set breakindent
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
set cpo+=n " line numbers for wrapped lines
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
set pastetoggle=<C-P>

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

" ferret
nmap <leader>z <Plug>(FerretAckWord)

"yaml

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
set foldlevelstart=20

let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' } }
let g:fzf_tags_command = 'ctags -R'

let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git/**' --glob '!build/**' --glob '!.dart_tool/**' --glob '!.idea'"

" files in fzf
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)

" advanced grep
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

" advanced grep(faster with preview)
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" mappings for fzf
nnoremap <silent> <C-B> :Buffers<Cr>
nnoremap <silent> <leader>e :Files<Cr>

" no auto folding
set nofoldenable
set foldmethod=indent
set foldminlines=2

set termguicolors
set cursorline

" GUI only config
set guifont=Sauce\ Code\ Powerline\ Light:h15

"set guifont=Source\ Code\ Pro\ Semibold:h15
set lines=40 columns=85

" colorscheme
colorscheme nightfly
"colorscheme onedark
"colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
"colorscheme dracula
"colorscheme base16-twilight
set bg=dark
let g:solarized_termcolors=256
