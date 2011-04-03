syntax on
filetype plugin indent on
set autoindent smartindent
set noexpandtab ts=8 sw=8
set backspace=indent,eol,start
set statusline=%<%f\ %h%m%y%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2
set encoding=utf-8
set background=dark

" /bin/sh is always POSIX, because what the fuck.
let g:is_posix = 1

let g:xterm16_colormap = 'soft'
let g:xterm16_brightness = 'high'
let &t_Co = 256
colo xterm16

nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
