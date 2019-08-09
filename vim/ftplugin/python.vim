let b:ale_fixers = ['black', 'isort']
let b:ale_linters = ['python', 'flake8']

if expand('%:t') !~? 'test_*'
  let b:ale_linters += ['mypy']
endif
