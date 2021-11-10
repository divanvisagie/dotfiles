syntax on "Basic syntax highlighting 

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4 "arrow shifts 4 spaces
set expandtab "convert tabs to spaces
set smartindent "try indent
set nowrap "no line wrapping
set noswapfile "does not create annoying vim swap files
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch "while you serch you get results 
set nu "Show line numbers

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

"Set up vim plugin loader, this loader works between the begin and end functions
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
"Autocomplete:
"Plug 'git@github.com:Valloric/YouCompleteMe.git' 
"Improved typescript syntax:
Plug 'leafgarland/typescript-vim'


call plug#end()

colorscheme gruvbox
set background=dark

let mapleader=" "

