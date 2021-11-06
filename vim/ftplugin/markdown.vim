scriptencoding utf-8
setlocal breakat-=*
setlocal linebreak
setlocal list
setlocal listchars=tab:»·,trail:·

let b:ale_fixers = ['pandoc']
let b:ale_linters_ignore = []
let g:vim_markdown_conceal = 0
let g:vim_markdown_frontmatter = 1
let b:ale_markdown_pandoc_options = '-dmarkdown-lint -'

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap <buffer> j gj
nnoremap <buffer> k gk

highlight link SpecialKey GruvboxOrange

call vim_wrapping_softhard#SetModeAutomatically()
