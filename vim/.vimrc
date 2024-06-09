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
set clipboard=unnamedplus
set colorcolumn=80
"stops issue where backspace doesnt work on some things
set backspace=indent,eol,start

highlight ColorColumn ctermbg=0 guibg=lightgrey

" Split down and to the right instead of left and to the top which is the
" weird default
set splitbelow
set splitright
let mapleader=" "

" Window resize
" Ensure mappings are fresh
nnoremap <C-j>:resize -2<CR>
nnoremap <C-k>:resize +2<CR>
nnoremap <C-h>:vertical resize -2<CR>
nnoremap <C-l>:vertical resize +2<CR>

" Function to set colors based on background
function! SetColors()
   if &background == "dark"
	   highlight LineNr ctermfg=DarkGray
	   highlight CursorLineNr ctermfg=LightGray
	   highlight SignColumn ctermbg=black ctermfg=DarkGray guibg=#1e1e1e guifg=#808080
	   highlight Visual ctermbg=DarkGray ctermfg=White guibg=#404040 guifg=#ffffff
       highlight VertSplit ctermbg=black ctermfg=black
   elseif &background == "light"
	   " Set split lines for light background
	   highlight LineNr ctermfg=Gray
	   highlight CursorLineNr ctermfg=Gray
	   highlight SignColumn ctermbg=white ctermfg=DarkGray guibg=#f5f5f5 guifg=#696969
	   highlight Visual ctermbg=LightGray ctermfg=Black guibg=#d3d3d3 guifg=#000000
       " colorscheme shine
       " no background
       highlight Normal guibg=NONE ctermbg=NONE
       highlight VertSplit ctermbg=black ctermfg=black
   endif
endfunction

highlight StatusLine ctermbg=black ctermfg=white
highlight StatusLineNC ctermbg=black ctermfg=white

" Automatically set the colors based on the background
augroup ChangeColors
   autocmd!
   autocmd OptionSet background call SetColors()
augroup END

" Manually call the function to set the colors
call SetColors()

function! Ripgrep(pattern)
   " Use ripgrep to search for the pattern and populate the quickfix list
   let l:command = 'rg --hidden --vimgrep ' . shellescape(a:pattern)
   cexpr systemlist(l:command)
   copen
endfunction
nnoremap <leader>rg :call Ripgrep(input('Rg Search: '))<CR>

" Function to search for file names using ripgrep and populate the quickfix list
function! RipgrepFilesByName(pattern)
   " Use ripgrep to search for files matching the pattern (including hidden files)
   let l:command = 'rg --files --hidden --glob "!.git/*" | rg ' . shellescape(a:pattern)
   let l:output = systemlist(l:command)
   " Convert ripgrep output to quickfix format: 'file:line:column:text'
   let l:quickfix_list = []
   for l:file in l:output
       call add(l:quickfix_list, {'filename': l:file, 'lnum': 1, 'col': 1, 'text': l:file})
   endfor
   " Populate the quickfix list
   call setqflist(l:quickfix_list)
   copen
endfunction

" Add a mapping to easily search for file names using ripgrep
nnoremap <leader>ff :call RipgrepFilesByName(input('Find File: '))<CR>
