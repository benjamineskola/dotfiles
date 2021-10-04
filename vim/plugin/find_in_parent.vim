if exists('g:loaded_find_in_parent')
  finish
endif
let g:loaded_find_in_parent = 1

function! FindInParent(file)
  let l:pattern = '%:h'
  let l:expanded = expand(l:pattern)
  while l:expanded !=? '/'
    if filereadable(l:expanded . '/' . a:file)
      return 1
    endif
    let l:pattern = l:pattern . ':h'
    if l:expanded == expand(l:pattern)
      break
    endif
    let l:expanded = expand(l:pattern)
  endwhile
  return 0
endfunction
