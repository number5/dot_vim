"let g:python3_host_prog = '/usr/local/bin/python3.8'
let g:python3_host_prog = '/usr/local/miniconda3/envs/fastapi/bin/python3'
let g:loaded_python_provider = 0

call plug#begin('~/.config/nvim/plugged')
" ColorSchemes
Plug 'dracula/vim', { 'as': 'dracula-theme' }
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'mhartington/oceanic-next'

Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons' " lua


Plug 'vim-scripts/gitignore'

" Languages
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

Plug 'junegunn/fzf.vim'
Plug 'vijaymarupudi/nvim-fzf'

" Extensions to built-in LSP, for example, providing type inlay hints
"Plug 'tjdevries/lsp_extensions.nvim'


Plug 'martinda/Jenkinsfile-vim-syntax'

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
""}}
Plug 'nathunsmitty/nvim-ale-diagnostic'

Plug 'saltstack/salt-vim'
Plug 'towolf/vim-helm'
Plug '$HOME/src/git/vim-hashicorp-tools'
Plug 'chr4/nginx.vim'
Plug 'LokiChaos/vim-tintin'

Plug 'majutsushi/tagbar'

" clojure
Plug 'tpope/vim-classpath'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
Plug 'p00f/nvim-ts-rainbow'
Plug 'Olical/conjure', {'tag': 'v4.18.0'}

Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
"{{
let g:indentLine_char_list = ['▏', '¦', '┆', '┊']
let g:indentLine_setColors = 0
let g:indentLine_setConceal = 0  " actually fix the annoying markdown links conversion
let g:indentLine_fileTypeExclude = ['startify']
"}}

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

Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-signify'

" Python syntax highlighting
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} "{{
let g:semshi#error_sign	= v:false
" }}

Plug 'conradirwin/vim-bracketed-paste'

call plug#end()



lua require 'init'

lua <<EOF
-- ALE diagnostics
require("nvim-ale-diagnostic")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

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


set autoread
set breakindent
set cmdheight=2 " Statusbar
set colorcolumn=80
set cpo+=n " line numbers for wrapped lines
set expandtab
set foldmethod=indent
set foldminlines=2
set gdefault
set ignorecase
set inccommand=nosplit
set linebreak
set nobackup " Disable Generation of Backup Files
set noequalalways
set nofoldenable
set nolz " do not redraw while running macros (much faster)
set noswapfile
set novisualbell
set number
set pastetoggle=<C-P>
set ruler
set secure
set shiftwidth=4  " set default to 4, need set to 2 for ruby type
set shortmess+=c " Avoid showing extra messages when using completion
set showbreak=↪\ \
set showmatch
set smartindent " Set Better Indention
set splitright
set switchbuf=useopen
set termguicolors
set title
set virtualedit=onemore
set wildignore+=*.pyc
set wildmenu         " make tab completion for files/buffers act like bash
set wildmode=longest,full " show a list when pressing tab and complete first full match


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
au FileType python set tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79

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

" super powerful spells here
cmap >fn <c-r>=expand('%:p')<cr>
cmap >fd <c-r>=expand('%:p:h').'/'<cr>
cmap w!! w !sudo tee % >/dev/null
"cmap W w

imap <F3> <C-R>=strftime("%x %r")<CR>


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

"yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
set foldlevelstart=20

" FZF
set rtp+=/usr/local/opt/fzf

let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' } }
let g:fzf_tags_command = 'ctags -R'

let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git/**' --glob '!build/**' --glob '!.dart_tool/**' --glob '!.idea'"

" files in fzf
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)

" advanced grep(faster with preview)
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

" mappings for fzf
nnoremap <silent> <C-B> :Buffers<Cr>
nnoremap <silent> <leader>e :Files<Cr>

" colorscheme
colorscheme nightfly
let g:gruvbox_contrast_dark='hard'
let g:solarized_termcolors=256
