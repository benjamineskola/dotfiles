augroup autoload
  autocmd!
  au CursorHold,CursorHoldI *
        \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' |
          \ checktime |
          \ if mode() == 'i' |
            \ call feedkeys("\<C-g>\<C-g>") |
          \ else |
            \ call feedkeys("f\e") |
          \ endif |
        \ endif
augroup END
