lua require('plugins')

set belloff=all
set concealcursor=nc
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
set foldmethod=expr
set grepformat=%f:%l:%c:%m
set grepprg=rg\ --vimgrep\ $*
set hidden
set history=10000
set hlsearch
set ignorecase smartcase
set inccommand=nosplit
set mouse+=a
set nomodeline
set number relativenumber
set pastetoggle=<F10>
set scrolloff=5
set shell=/bin/sh
set signcolumn=yes
set spell spelllang=en_gb
set undofile
set viewoptions=folds
set wrap

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline_powerline_fonts = 1

let g:cursorhold_updatetime = 100

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

let g:mundo_prefer_python3 = 1

let g:netrw_home = stdpath('cache')

let g:sort_motion_flags = 'i'

let test#strategy = 'dispatch'
