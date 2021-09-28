augroup autoload
  autocmd!
  au CursorHold *
        \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' |
          \ checktime |
          \ call feedkeys("f\e") |
        \ endif
  au CursorHoldI *
        \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' |
          \ checktime |
          \ call feedkeys("\<C-g>\<C-g>") |
        \ endif
augroup END
