augroup terminal
  autocmd!
  autocmd TerminalOpen * if &filetype !=# 'fzf' | tnoremap <buffer> <Esc> <C-\><C-n><Cmd>bd!<CR> | endif
  autocmd TerminalOpen * setlocal nonumber norelativenumber
augroup END
