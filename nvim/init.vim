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
	set guifont=Fira_Code:h14

	let g:neovide_hide_mouse_when_typing = v:true
	let g:neovide_cursor_animation_length = 0
	let g:neovide_remember_window_size = v:true

	cnoreabbrev bd Bdelete
	cnoreabbrev q Bdelete
	cnoreabbrev qa only!\|bufdo Bdelete
	cnoreabbrev qall only!\|bufdo Bdelete
	cnoreabbrev qa! only!\|bufdo Bdelete!
	cnoreabbrev qall! only!\|bufdo Bdelete!
	cnoreabbrev wq w\|Bdelete
	cnoreabbrev wqa wa\|only!\|bufdo Bdelete
	cnoreabbrev wqall wa\|only!\|bufdo Bdelete
	cnoreabbrev wqa! wa!\|only!\|bufdo Bdelete!
	cnoreabbrev wqall! wa!\|only!\|bufdo Bdelete!
	cnoreabbrev x up
	cnoreabbrev xit update

	nnoremap ZZ <Cmd>update<CR>
	nnoremap ZQ <Cmd>only!\|bufdo Bdelete!<CR>

	cnoremap <D-v> <C-R>+
	inoremap <D-v> <C-R>+
	nnoremap <D-v> "*p
	vnoremap <D-c> "*y
	vnoremap <D-v> "*p
endif
