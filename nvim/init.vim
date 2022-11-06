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

if exists('g:neovide')
	lua require("ginit")
endif
