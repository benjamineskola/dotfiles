function! s:RubyAutocorrect(current_args)
  " check rubocop exists
  silent! let l:status = system('which rubocop')

  if l:status !~ '\w\+'
      echo 'rubocop not found'
      return 0
  endif

  "save cursor position
  let l:cursor_position = getcurpos()

  " write the buffer to a tempfile, process that with rubocop, then read that
  " back in, cleaning up the tempfile afterwards
  let l:tempfile = tempname() . '.rb'
  silent execute "%w " . l:tempfile
  silent execute "%!rubocop --auto-correct " . l:tempfile . ">/dev/null 2>&1 && cat " . l:tempfile
  call delete(l:tempfile)

  " Reset the cursor position if we moved
  if l:cursor_position != getcurpos()
    call setpos('.', l:cursor_position)
endif
endfunction

command! -nargs=? RubyAutocorrect :call <SID>RubyAutocorrect(<q-args>)
autocmd BufWritePre <buffer> RubyAutocorrect
