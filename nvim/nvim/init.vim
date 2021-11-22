syntax on "enable syntax highlighting

set termguicolors
set nocompatible "disable backward compatibility with vi
set mouse=a "enable mouse for all modes
set scrolloff=8 "scroll 8 lines before file edge
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
set undodir=~/.vim/nvim/undodir
set undofile
set incsearch "while you serch you get results 
"do relative line numbers with hybrid:
" https://medium.com/geekculture/neovim-configuration-for-beginners-b2116dbbde84
set number relativenumber
set nu rnu
set clipboard=unnamed "copy to global clipboard
set colorcolumn=80
"stops issue where backspace doesnt work on some things
set backspace=indent,eol,start
" show plugins errors etc in margin:
set signcolumn=yes
"set termguicolors
set guicursor= " Make the thin cursor tick again
set cmdheight=1 "size of the place at the bottom of the window where you type
" set the margin color to grey
highlight ColorColumn ctermbg=0 guibg=lightgrey 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
" Themes
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
"Autocomplete and language servers
"Plug 'neovim/nvim-lspconfig'
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
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Be able to change quotes and other surrounds with: cs'" for example
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set themes and color schemes as well as plugin setups
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:airline_theoue='bubblegum'
" Split down and to the right instead of left and to the top which is the
" weird default
set splitbelow
set splitright
let mapleader=" "
let g:lsp_fold_enabled = 0 "Disable lsp folding
let g:ackprg = 'ack'
let g:lsp_diagnostics_echo_cursor = 1 "Show the lsp error at this line
let g:airline#extensions#tabline#formatter = 'unique_tail'
let NERDTreeShowHidden=1 "Show the hidden files in NERDTree
colorscheme gruvbox
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Configurations for autocomplete plugin
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
"Force refresh autocomplete
imap <c-space> <Plug>(asyncomplete_force_refresh)

nnoremap <leader>n :NERDTreeToggle<CR>
"Activate with Ctrl where C = Ctrl
nnoremap <C-f> :NERDTreeFind<CR>
"language server stuff
nnoremap <leader>gd :LspDefinition<CR>
nnoremap <leader>pd :LspPeekDefinition<CR>
nnoremap <leader>gi :LspImplementation<CR>
nnoremap <leader>pi :LspPeekImplementation<CR>
nnoremap <leader>r :LspRename<CR>
nnoremap <leader>c. :LspCodeAction<CR>
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
map <leader>qw :q<cr>
"telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

"Exit terminal mode
tnoremap <Esc> <C-\><C-n>
"open a terminal at the bottom of the current buffer
function SpawnTerm()
    split | terminal 
    15 winc -
endfunction
nnoremap <leader>ot :call SpawnTerm()<CR>

