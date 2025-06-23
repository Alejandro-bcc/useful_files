" =============================================================================
"  1. GENERAL SETTINGS
" =============================================================================
syntax on
set tabstop=4      " Number of visual spaces per tab.
set shiftwidth=4   " Number of spaces to use for auto-indenting.
set softtabstop=4  " Number of spaces that a <Tab> counts for.
set expandtab      " Use spaces instead of tabs.
set autoindent     " Copy indent from current line when starting a new line.
set smartindent    " Be smart about indentation.
set background=dark
set termguicolors  " Enable 24-bit RGB color
set number " Show line numbers:
" Go to the position I was when last editing the file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" =============================================================================
"  2. APPEARANCE (Custom Colors)
" =============================================================================
" Your custom color definitions are preserved
highlight Normal guibg=#171421 guifg=#FFFFFF
highlight LineNr guibg=#171421 guifg=#888888
highlight Statement term=underline cterm=bold ctermfg=darkcyan guifg=Yellow
highlight CursorLine guibg=#222233
highlight CursorLineNr guifg=#FFD700
highlight Visual guibg=#333344

" =============================================================================
"  3. PLUGIN MANAGER (vim-plug)
" =============================================================================
" To install: curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Then open vim and run :PlugInstall
call plug#begin('~/.vim/plugged')

" Appearance Plugins
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons' " For icons in lightline and nerdtree

" Functionality Plugins
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs' " Replaces your manual inoremaps
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion

call plug#end()

" =============================================================================
"  4. PLUGIN CONFIGURATION
" =============================================================================
" NERDCommenter: Add spaces after comment delimiters
let g:NERDSpaceDelims = 1

" NERDTree: Toggle with Ctrl+n
nnoremap <C-n> :NERDTreeToggle<CR>

" FZF: Find files with Ctrl+p
nnoremap <C-p> :Files<CR>

" CoC: Autocompletion key mappings
" Use Tab for navigating the completion menu ONLY when it's visible.
" This restores normal tab behavior for indentation.
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Use Ctrl+Space to manually trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" GitGutter: Always show signs
let g:gitgutter_sign_priority = 2

" =============================================================================
"  5. CUSTOM MAPPINGS
" =============================================================================

" Save and Quit with leader key (space)
let mapleader = " "
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
