set tabstop=4
set autoindent
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap " ""<Left>
inoremap { {<CR>}<up><end>
inoremap cmt /*   */<Left><Left><Left><Left>
" go to the position I was when last editing the file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

"apperance"
set number
syntax on
set termguicolors
set background=dark

" Personalizar cores (usando apenas valores válidos para cterm e GUI)
syntax on
set termguicolors  " Habilitar suporte a cores verdadeiras (24-bit)
set background=dark

" Definir a cor de fundo personalizada
highlight Normal guibg=#171421 guifg=#FFFFFF  " Fundo escuro e texto branco
highlight LineNr guibg=#171421 guifg=#888888  " Números das linhas discretos
highlight Statement term=underline cterm=bold ctermfg=darkcyan guifg=Yellow
highlight CursorLine guibg=#222233           " Fundo da linha atual mais claro
highlight CursorLineNr guifg=#FFD700         " Número da linha atual em amarelo
highlight Visual guibg=#333344               " Fundo para seleção visual

