if !exists('b:ale_fixers')
  let b:ale_fixers = ['prettier']
  let b:ale_linters_ignore = ['proselint']
endif

let b:ale_javascript_prettier_options='--bracket-same-line --print-width=90'

set expandtab
set shiftwidth=2
set softtabstop=2
