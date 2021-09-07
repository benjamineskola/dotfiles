let b:ale_fixers = ['isort', 'black']
let b:ale_linters = ['python', 'flake8']
let g:jedi#completions_enabled = 0
let g:jedi#goto_command = 'gd'
let g:jedi#goto_assignments_command = ''

if expand('%:t') !~? 'test_*'
  let b:ale_linters += ['mypy']
endif

let b:ale_command_wrapper = 'asdf env python'
let pattern = '%:h'
while expand(pattern) !=? '/'
  if filereadable(expand(pattern) . '/poetry.lock')
    let b:ale_command_wrapper .= ' poetry run'
    break
  endif
  let pattern = pattern . ':h'
endwhile
unlet pattern

call SuperTabSetDefaultCompletionType('<c-n>')

let g:projectionist_heuristics = {
  \ 'Pipfile|requirements.txt': {
    \   '*/views/__init__.py': {
    \      'type': 'view',
    \      'alternate': 'tests/test_views.py',
    \   },
    \   '**/views/*.py': {
    \      'type': 'view',
    \      'alternate': '{dirname}/tests/views/test_{basename}.py',
    \   },
    \   '*/views.py': {
    \      'type': 'view',
    \      'alternate': '{dirname}/tests/test_views.py',
    \   },
    \   '*/models/__init__.py': {
    \      'type': 'model',
    \      'alternate': '{dirname}/tests/test_models.py',
    \   },
    \   '**/models/*.py': {
    \      'type': 'model',
    \      'alternate': '{dirname}/tests/models/test_{basename}.py',
    \   },
    \   '*/models.py': {
    \      'type': 'model',
    \      'alternate': '{dirname}/tests/test_models.py',
    \   },
    \   '**/tests/views/test_*.py': {
    \      'type': 'test',
    \      'alternate': '{dirname}/views/{basename}.py',
    \   },
    \   '**/tests/models/test_*.py': {
    \      'type': 'test',
    \      'alternate': '{dirname}/models/{basename}.py',
    \   },
    \   '*.py': {
    \      'alternate': '{dirname}/tests/test_{basename}.py',
    \      'template': ['class {basename|camelcase|capitalize}:', '    pass'],
    \   },
    \   '**/tests/test_*.py': {
    \      'type': 'test',
    \      'alternate': '{}.py',
    \   },
  \ },
\ }
