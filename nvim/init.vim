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

if exists('g:neovide')
	set guifont=Fira_Code:h14

	let g:neovide_hide_mouse_when_typing = v:true
	let g:neovide_cursor_animation_length = 0
	let g:neovide_remember_window_size = v:true

	augroup NeovideTransparency
		autocmd!
		autocmd VimEnter,WinEnter * set winblend=100 pumblend=100
	augroup END

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

	inoremap <D-v> <Esc>"*pi
	vnoremap <D-c> "*y
endif
