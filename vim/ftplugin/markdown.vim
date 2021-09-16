let b:ale_fixers = ['remark-lint']
let g:vim_markdown_conceal = 0
let g:vim_markdown_frontmatter = 1

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap <buffer> j gj
nnoremap <buffer> k gk

" Some but not all markdown files should be hard wrapped
augroup markdown
  autocmd!
  au BufNewFile,BufRead */govuk/*,README.md setlocal formatoptions+=a
augroup END
