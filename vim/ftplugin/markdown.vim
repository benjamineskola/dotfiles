scriptencoding utf-8
setlocal breakat-=*
setlocal linebreak
setlocal list
setlocal listchars=tab:»·,trail:·

let b:ale_fixers = ['pandoc']
let g:vim_markdown_conceal = 0
let g:vim_markdown_frontmatter = 1
let b:ale_markdown_pandoc_options = '-dmarkdown-lint -'

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap <buffer> j gj
nnoremap <buffer> k gk

highlight link SpecialKey GruvboxOrange

call vim_wrapping_softhard#SetModeAutomatically()

function! PandocWordcount()
  let output = system('pandoc -C -L ~/Code/lua-filters/wordcount/wordcount.lua "' . bufname("%") .'" 2>/dev/null')
  return split(output, ' ')[0]
endfunction

function! UpdateWordcount()
  let save_cursor = getpos('.')
  call setpos('.', [save_cursor[0], 2, save_cursor[2], save_cursor[3]])

  let end_line = search('^---$', 'cn')
  if end_line == 0
    return
  endif

  if match(getline(1, end_line), '^wordcount') == -1
    call append(end_line - 1, ['wordcount: 0'])
  endif

  keepjumps exe '1,' . end_line . 's#^\(.\{,10}wordcount: \).*#\1' .
        \ PandocWordcount() . '#e'
  call histdel('search', -1)
  call setpos('.', save_cursor)
endfunction

if expand('%:p') =~? '.*/essays/.*'
  augroup markdown_essay
    autocmd!
    autocmd BufWritePre *.md call UpdateWordcount()
  augroup END
endif
