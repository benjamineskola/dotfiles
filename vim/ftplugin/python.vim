let b:ale_fixers = ['isort', 'black']
let b:ale_linters = ['python', 'flake8']
let g:jedi#completions_enabled = 0
let g:jedi#goto_command = 'gd'
let g:jedi#goto_assignments_command = ''

if expand('%:t') !~? 'test_.*'
  let b:ale_linters += ['mypy']
endif

let g:ale_python_auto_pipenv = 1
let g:ale_python_auto_poetry = 1

let b:ale_python_isort_options = '--profile black'

call SuperTabSetDefaultCompletionType('<c-n>')
