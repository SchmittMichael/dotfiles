set ic
set relativenumber
set number
nnoremap <SPACE> <Nop>
let mapleader=" "

" window navigation
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-l> :wincmd l<CR>

" clipboard config
set clipboard=unnamed
nnoremap <silent> <leader>y "+y
vnoremap <silent> <leader>y "+y

" scrolloff 
set scrolloff=8

" split
set splitright
set splitbelow

" custom shortcuts
command! Q qa!
command! Spell setlocal spell spelllang=en_us

" indentation
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
