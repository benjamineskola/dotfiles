let b:ale_fixers = ['black', 'isort']
let b:ale_linters = ['python', 'flake8']

if expand('%:t') !~? 'test_*'
  let b:ale_linters += ['mypy']
endif

call SuperTabSetDefaultCompletionType("<c-n>")

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
