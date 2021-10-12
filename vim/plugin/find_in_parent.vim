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

function! GetGitRoot()
  return systemlist('cd ' . shellescape(expand('%:p:h')) . '; git rev-parse --show-toplevel')[0]
endfunction

function! FindInGitRoot(pattern)
  return len(glob(GetGitRoot() . '/' . a:pattern, 0, 1)) > 0
endfunction
