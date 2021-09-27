setlocal linebreak
setlocal list
setlocal listchars=tab:»·,trail:·

let b:ale_fixers = ['pandoc']
let g:vim_markdown_conceal = 0
let g:vim_markdown_frontmatter = 1
let b:ale_markdown_pandoc_options = '-s --wrap none -t markdown -t markdown-smart'

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap <buffer> j gj
nnoremap <buffer> k gk

" Some but not all markdown files should be hard wrapped
augroup markdown
  autocmd!
  au BufNewFile,BufRead */govuk/*,README.md setlocal formatoptions+=a
augroup END

highlight link SpecialKey GruvboxOrange
