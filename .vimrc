set autoindent smartindent
set backspace=indent,eol,start
set encoding=utf-8
set ignorecase smartcase hlsearch
set laststatus=2
set noexpandtab ts=8 sw=8
set number
set pastetoggle=<F11>
set showcmd
set statusline=%<%f\ %h%m%y%r%=%-14.(%l,%c%V%)\ %P
set t_ti= t_te=
set wildmenu
set t_ti= t_te=

" appearance.
set background=dark
let g:xterm16_colormap = 'soft'
let g:xterm16_brightness = 'high'
let &t_Co = 256
colo xterm16
syntax on

" filetype stuff.
filetype plugin indent on
let g:is_posix = 1 " /bin/sh is always POSIX, because what the fuck.

map <Tab> :bnext<CR>
map <S-Tab> :bprevious<CR>

map Y y$
nmap <C-l> :nohl<CR>:redraw<CR>
