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
set statusline=%<%f\ %h%m%y%r%=%-14.(%l,%c%V%)\ %P
set wildmenu

" appearance.
set background=dark
syntax on
colorscheme default

" filetype stuff.
filetype plugin indent on
let g:is_posix = 1 " /bin/sh is always POSIX, because what the fuck.

au FileType python set expandtab ts=4 sw=4 sts=4
au FileType nginx,puppet,vim,ruby set expandtab ts=2 sw=2 sts=2

map <Tab> :bnext<CR>
map <S-Tab> :bprevious<CR>
cabbrev tabe e
cabbrev tabclose bdel

map Y y$
map qq ZZ
nmap <C-l> :nohl<CR>:redraw<CR>

command! W w !sudo tee % > /dev/null

function! BindTimestamp()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#\( \+\)\d\+\( *; serial\)#' .
          \ '\1' . strftime('%s') . '\2#'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun
autocmd BufWritePre *.db call BindTimestamp()
