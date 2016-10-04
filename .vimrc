execute pathogen#infect()

set autoindent
set backspace=indent,eol,start
set cpoptions+=n
set encoding=utf-8
set hidden
set ignorecase smartcase hlsearch incsearch
set laststatus=2
set modeline
set noexpandtab ts=8 sw=8
set number
set pastetoggle=<F10>
set showcmd
set wildmenu

" appearance.
set background=dark
syntax on
colorscheme solarized

" filetype stuff.
filetype plugin indent on
let g:is_posix = 1 " /bin/sh is always POSIX, because what the fuck.

au FileType python set expandtab ts=4 sw=4 sts=4
au FileType nginx,puppet,vim,ruby set expandtab ts=2 sw=2 sts=2

map Y y$
map qq ZZ
nmap <C-l> :nohl<CR>:redraw<CR>

let mapleader= ","
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>
