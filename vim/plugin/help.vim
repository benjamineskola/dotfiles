augroup help_resize
  autocmd!
  autocmd BufEnter * if &buftype == 'help' && &columns > 120 && &columns == winwidth(0) | wincmd L | endif
augroup END
