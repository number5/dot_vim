" User Interface
" --------------
" activate wildmenu, permanent ruler and disable Toolbar, and add line
" highlightng as well as numbers
set wildmenu
set completeopt-=preview
set guifont=Droid\ Sans\ Mono\ 11
set lines=36 columns=82


set langmenu=en_US.utf-8
language mes en_US.UTF-8
 
set guioptions+=c
set guioptions-=e
set guioptions-=T
set guioptions-=m
set guioptions-=r

" key mapping for cut/copy/paste
imap <C-X> "+x
imap <C-C> "+y 
imap <C-V> "+gP

