let b:ale_fixers = ['prettier']
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

" Don't require a --- delimiter for yaml frontmatter: support pelican
if get(g:, 'vim_markdown_frontmatter', 0)
  syn include @yamlTop syntax/yaml.vim
  syn region Comment matchgroup=mkdDelimiter start="\%^" end="^$" contains=@yamlTop keepend
  unlet! b:current_syntax
endif
