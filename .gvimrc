" User Interface
" --------------
" activate wildmenu, permanent ruler and disable Toolbar, and add line
" highlightng as well as numbers
set wildmenu
set completeopt-=preview
set guifont=Droid\ Sans\ Mono\ 12
set lines=36 columns=82
set t_Co=256
set background=dark
colorscheme wombat256mod


set langmenu=en_US.utf-8
language mes en_US.UTF-8
 
set guioptions+=c
set guioptions-=e
set guioptions-=T
set guioptions-=m
set guioptions-=r

" key mapping for cut/copy/paste
imap <C-X> <Esc>"+x
"imap <C-C> <Esc>"+y 
"imap <C-V> <Esc>"+gP



