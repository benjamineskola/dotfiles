set hidden
set ignorecase smartcase
set modeline
set noexpandtab ts=8 sw=8
set number
set pastetoggle=<F10>

" appearance.
let fg_bg = split($COLORFGBG, ";")

if(fg_bg[1] == 8 || fg_bg[1] == 15)
  colo solarized
else
  colo slate
end
syntax on

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
