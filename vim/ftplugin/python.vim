let b:ale_fixers = ['black', 'isort']
let b:neomake_python_enabled_makers = ['python', 'flake8']
let g:neomake_python_exe = '/usr/local/bin/python3'

if expand('%:t') !~ 'test_*'
  let b:neomake_python_enabled_makers += ['mypy']
endif
