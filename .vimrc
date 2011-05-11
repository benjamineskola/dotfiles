set autoindent
set backspace=indent,eol,start
set encoding=utf-8
set ignorecase smartcase hlsearch incsearch
set laststatus=2
set modeline
set noexpandtab ts=8 sw=8
set number
set pastetoggle=<F11>
set showcmd
set statusline=%<%f\ %h%m%y%r%=%-14.(%l,%c%V%)\ %P
set t_ti= t_te=
set wildmenu

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

au FileType python set expandtab ts=4 sw=4 sts=4

let g:NERDSpaceDelims = 1

map <Tab> :bnext<CR>
map <S-Tab> :bprevious<CR>

map Y y$
nmap <C-l> :nohl<CR>:redraw<CR>

" emacs-like editing in command mode
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-D> <Del>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
cnoremap <Esc><C-B> <S-Left>
cnoremap <Esc><C-F> <S-Right>

" no cursor keys or pageup/pagedown/home/end
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
map <PageUp> <nop>
map <PageDown> <nop>
map <Home> <nop>
map <End> <nop>

imap <up> <Esc>
imap <down> <Esc>
imap <left> <Esc>
imap <right> <Esc>
imap <PageUp> <Esc>
imap <PageDown> <Esc>
imap <Home> <Esc>
imap <End> <Esc>

nnoremap / /\v
vnoremap / /\v

nnoremap ; :
