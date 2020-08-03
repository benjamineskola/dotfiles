runtime plugins.vim

set foldmethod=marker
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
let g:airline_powerline_fonts = 0
let g:airline_theme = 'gruvbox'

let g:ale_fix_on_save = 1
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
let g:ale_open_list = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

let g:deoplete#enable_at_startup = 1

let g:jedi#completions_enabled = 0
let g:jedi#goto_command = '<leader>D'
let g:jedi#goto_assignments_command = '<leader>G'

let g:LanguageClient_serverCommands = {
    \ 'ruby': [ $ASDF_DATA_DIR . '/shims/solargraph', 'stdio'],
    \ }

let g:vim_markdown_conceal = 0
let g:vim_markdown_frontmatter = 1

let g:mundo_prefer_python3 = 1

let g:netrw_home = stdpath('cache')

let g:sort_motion_flags = 'i'

let g:tmpl_search_paths = [stdpath('config') . '/templates']

let test#strategy = 'neovim'

au CursorHold * checktime | call feedkeys("lh")
