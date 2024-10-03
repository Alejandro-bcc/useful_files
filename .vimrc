syntax on
set tabstop=4
set autoindent
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap " ""<Left>
inoremap { {<CR>}<up><end>
inoremap cmt /*   */<Left><Left><Left><Left>
" go to the position I was when last editing the file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
