if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
  Plug 'airblade/vim-gitgutter'
  Plug 'benjamineskola/vim-applescript'
  Plug 'christoomey/vim-sort-motion' | Plug 'kana/vim-textobj-indent'
  Plug 'dag/vim-fish'
  Plug 'danielwe/base16-vim'
  Plug 'derekwyatt/vim-scala'
  Plug 'elixir-lang/vim-elixir'
  Plug 'ervandew/supertab'
  Plug 'mileszs/ack.vim'
  Plug 'nelstrom/vim-textobj-rubyblock' | Plug 'kana/vim-textobj-user'
  Plug 'neomake/neomake'
  Plug 'pangloss/vim-javascript'
  Plug 'Raimondi/delimitMate'
  Plug 'rust-lang/rust.vim'
  Plug 'sjl/gundo.vim'
  Plug 'sjl/splice.vim'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-ruby/vim-ruby'
  Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
  Plug 'z0mbix/vim-shfmt', { 'for': ['sh', 'bash'] }
call plug#end()

set autoindent
set backspace=indent,eol,start
set encoding=utf-8
set guifont=Fira\ Code:h14
set hidden
set hlsearch incsearch
set ignorecase smartcase
set laststatus=2
set nomodeline
set number relativenumber
set pastetoggle=<F10>
set shell=/bin/bash
set showcmd
set wildmenu

set grepprg=rg\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

" appearance.
set termguicolors
colo base16-materia
syntax on

" filetype stuff.
filetype plugin indent on
let g:is_posix = 1 " /bin/sh is always POSIX, because what the fuck.

au FileType applescript,javascript,sh,vim,zsh set sts=2 sw=2 expandtab
au FileType haskell set sts=4 sw=4 expandtab

" plugin settings
let g:ackprg = 'rg --vimgrep --hidden'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline_powerline_fonts = 1

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

let g:Lf_CacheDirectory = $HOME . '/Library/Caches'
let g:Lf_CommandMap = {'<C-T>': ['<CR>']}

let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

call neomake#configure#automake('nrwi', 500)
autocmd! BufReadPost,BufWritePost,BufWinEnter * Neomake
let g:neomake_open_list = 2
let g:neomake_python_exe = '/usr/local/bin/python3'

au FileType * let g:shfmt_extra_args = '-i 2 -p -s'
au FileType zsh,bash let g:shfmt_extra_args = '-i 2 -s'
let g:shfmt_fmt_on_save = 1

let g:sort_motion_flags = "i"

" mappings
let mapleader = ","

nmap <C-l> :nohl<CR>:redraw<CR>

let g:nremap = {"]t": "", "[t": ""}
map ]t gt
map [t gT

nnoremap <F5> :GundoToggle<CR>

imap § <ESC>

cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

au BufWritePre * :silent v/\_s*\S/d
au BufWritePre * :silent g/\s\+$/s/\s\+$//

let $BASH_ENV = $HOME . "/.bash_profile"
