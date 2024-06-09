syntax on "Basic syntax highlighting 

set nocompatible "disable backward compatibility with vi
set laststatus=2 "show status line
set statusline=%f "status line format
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

" Line number settings
" do relative line numbers with hybrid:
set number relativenumber
" set numbers to grey
highlight LineNr guifg=#808080 ctermfg=grey
set numberwidth=5

set nu rnu
set clipboard=unnamed "copy to global clipboard
set colorcolumn=80
"stops issue where backspace doesnt work on some things
set backspace=indent,eol,start

highlight ColorColumn ctermbg=0 guibg=lightgrey


" let g:airline_theme='bubblegum'
" Split down and to the right instead of left and to the top which is the
" weird default
set splitbelow
set splitright
let mapleader=" "

