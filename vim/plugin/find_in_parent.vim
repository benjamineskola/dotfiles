if exists('g:loaded_find_in_parent')
  finish
endif
let g:loaded_find_in_parent = 1

function! FindInParent(file)
  let l:pattern = '%:h'
  while expand(pattern) !=? '/'
    if filereadable(expand(pattern) . '/' . a:file)
      return 1
    endif
    let l:pattern = l:pattern . ':h'
  endwhile
  return 0
endfunction
