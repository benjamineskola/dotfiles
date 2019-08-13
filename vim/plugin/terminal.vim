augroup terminal_settings
  autocmd!
  if has('nvim')
    autocmd TermOpen * setlocal nonumber norelativenumber
  else
    autocmd TerminalOpen * setlocal nonumber norelativenumber
  endif
augroup END
