scriptencoding utf-8
setlocal breakat-=*
setlocal linebreak
setlocal list
setlocal listchars=tab:»·,trail:·

let g:vim_markdown_conceal = 0
let g:vim_markdown_frontmatter = 1

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap <buffer> j gj
nnoremap <buffer> k gk

highlight link SpecialKey GruvboxOrange
