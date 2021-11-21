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
"do relative line numbers with hybrid:
set number relativenumber
set nu rnu
set clipboard=unnamed "copy to global clipboard
set colorcolumn=80
"stops issue where backspace doesnt work on some things
set backspace=indent,eol,start

highlight ColorColumn ctermbg=0 guibg=lightgrey

"Set up plugin loader, this loader works between the begin and end functions
call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
"Autocomplete and language servers
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
"Improved typescript syntax:
Plug 'leafgarland/typescript-vim'
"Tree explorer
Plug 'preservim/nerdtree'
"Search with ack
Plug 'idbrii/vim-notgrep'
Plug 'mileszs/ack.vim'
"Fuzzy file search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Be able to change quotes and other surrounds with: cs'" for example
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
call plug#end()

colorscheme gruvbox
set background=dark
" let g:airline_theme='bubblegum'
" Split down and to the right instead of left and to the top which is the
" weird default
set splitbelow
set splitright
let mapleader=" "
let g:lsp_fold_enabled = 0 "Disable lsp folding
let g:ackprg = 'ack'
let g:lsp_diagnostics_echo_cursor = 1 "Show the lsp error at this line
let g:lsp_diagnostics_float_cursor = 1 "Show the error on the line as a popup

let g:airline#extensions#tabline#formatter = 'unique_tail'

"Configurations for autocomplete plugin
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
"Force refresh autocomplete
imap <c-space> <Plug>(asyncomplete_force_refresh)

nnoremap <leader>n :NERDTreeToggle<CR>
"Activate with Ctrl where C = Ctrl
nnoremap <C-f> :NERDTreeFind<CR>
"Fuzzy file finder
nnoremap <leader>f :FZF<CR>
"language server stuff
nnoremap <leader>gd :LspDefinition<CR>
nnoremap <leader>pd :LspPeekDefinition<CR>
nnoremap <leader>gi :LspDeclaration<CR>
nnoremap <leader>pi :LspPeekDeclaration<CR>
nnoremap <leader>r :LspRename<CR>
nnoremap <leader>ca :LspCodeAction<CR>
nnoremap <leader>td :LspTypeDefinition<CR>
nnoremap <leader>is :LspInstallServer<CR>
nnoremap <leader>fr :LspReferences<CR>
"change to current file's directory
nnoremap <leader>cd :cd %:p:h<CR>
"tab controls
map <C-n> :tabnew<cr>
map <C-t> :tabnext<cr>
nnoremap <leader>tm :tabmove<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>to :tabonly<cr>
"Easy window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"shortcuts
map <C-s> :w<cr>

"open a terminal at the bottom of the current buffer
function SpawnTerm()
    bel term 
    15 winc -
endfunction
nnoremap <leader>ot :call SpawnTerm()<CR>

