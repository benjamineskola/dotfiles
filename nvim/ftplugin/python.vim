let b:ale_fixers = ['isort', 'black']
let b:ale_linters = ['python', 'flake8']
let g:jedi#completions_enabled = 0
let g:jedi#goto_command = 'gd'
let g:jedi#goto_assignments_command = ''

if expand('%:t') !~? 'test_*'
  let b:ale_linters += ['mypy']
endif

let g:ale_python_auto_pipenv = 1
let g:ale_python_auto_poetry = 1

let b:ale_python_isort_options = '--profile black'

call SuperTabSetDefaultCompletionType('<c-n>')

let g:projectionist_heuristics = {
  \ 'Pipfile|requirements.txt|pyproject.toml': {
    \   '*/views/__init__.py': {
    \      'type': 'view',
    \      'alternate': 'tests/test_views.py',
    \   },
    \   '**/views/*.py': {
    \      'type': 'view',
    \      'alternate': '{dirname}/tests/views/test_{basename}_view.py',
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
    \   '**/tests/views/test_*_view.py': {
    \      'type': 'test',
    \      'alternate': '{dirname}/views/{basename}.py',
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
    \      'alternate': '{project}/tests/test_{basename}.py',
    \      'template': ['class {basename|camelcase|capitalize}:', '    pass'],
    \   },
    \   '**/tests/test_*.py': {
    \      'type': 'test',
    \      'alternate': '{}.py',
    \   },
  \ },
\ }
