set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-pathogen'
Bundle 'sjl/threesome.vim'
Bundle 'sjl/gundo.vim'
Bundle 'vim-scripts/nginx.vim'
Bundle 'cypok/vim-ledger'
Bundle 'msanders/cocoa.vim'
Bundle 'tpope/vim-speeddating'
Bundle 'derekwyatt/vim-scala'
Bundle 'nvie/vim-flake8'
Bundle 'tpope/vim-markdown'

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
set t_ti= t_te=
set wildmenu
set guifont=Menlo\ Regular:h12
set guioptions-=T
set mouse+=a
set list listchars=tab:▸\ ,eol:¬

" appearance.
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

set background=dark
let g:xterm16_colormap = 'soft'
let g:xterm16_brightness = 'high'
let &t_Co = 256
colo xterm16
syntax on

highlight LineNr ctermbg=none

" filetype stuff.
filetype plugin indent on
let g:is_posix = 1 " /bin/sh is always POSIX, because what the fuck.

fun! HighlightWhitespace()
  if &ft =~ 'mail\|lisp'
    return
  endif

  syn match ExtraWhitespace /\s\+$/ containedin=ALL
  syn match ExtraWhiteSpace /\t\+ \t*/ containedin=ALL
  syn match ExtraWhiteSpace /\t* \t\+/ containedin=ALL

  if &ft == 'python'
    syn match ExtraWhitespace /^ *\t\+ */ containedin=ALL
  endif
endfun

au Syntax * call HighlightWhitespace()
au FileType python set expandtab ts=4 sw=4 sts=4
au FileType nginx,puppet,vim set expandtab ts=2 sw=2 sts=2

let g:NERDSpaceDelims = 1

if has("gui_running")
  map <Tab> :tabnext<CR>
  map <S-Tab> :tabprevious<CR>
else
  map <Tab> :bnext<CR>
  map <S-Tab> :bprevious<CR>
endif

map Y y$
nmap <C-l> :nohl<CR>:redraw<CR>

command! W w !sudo tee % > /dev/null

nnoremap <F5> :GundoToggle<CR>

nmap [o O<Esc>
nmap ]o o<Esc>
nmap [e ddkP<Esc>
nmap ]e ddp<Esc>

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
