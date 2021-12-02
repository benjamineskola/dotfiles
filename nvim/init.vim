runtime plugins.vim

set belloff=all
set concealcursor=nc
set foldlevelstart=99
set foldmethod=indent
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
set updatetime=1000
set viewoptions=folds

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline_powerline_fonts = 1

let g:ale_fix_on_save = 1
let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'] }
let g:ale_open_list = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

let g:mundo_prefer_python3 = 1

let g:netrw_home = stdpath('cache')

let g:sort_motion_flags = 'i'

let test#strategy = 'dispatch'

function! DeleteEmptyBuffers()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')

  if !empty(buffers)
      exe 'bw' . join(buffers, ' ')
  endif
endfunction

augroup vimrc
  autocmd!
  au TabNew * :tabclose
  au BufRead,BufNewFile * exe DeleteEmptyBuffers()
augroup END

augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | cclose | endif
augroup END

lua require('gitsigns').setup()
lua <<EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-h>"] = actions.which_key,
        ["<CR>"] = function(prompt_bufnr)
          local path = require("telescope.actions.state").get_selected_entry(prompt_bufnr).value
          local f = io.open(path, "r")
          local ok, err, code = f:read(1)
          f:close()
          if code == 21 then -- EISDIR
            actions.close(prompt_bufnr)
            vim.fn.execute("cd " .. path, "silent")
          else
            actions.select_default(prompt_bufnr)
          end
        end
      },
    },
  }
}
require('telescope').load_extension('fzf')
EOF
