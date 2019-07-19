let b:ale_fixers = ['black', 'isort']
let b:ale_linters = ['python', 'flake8']

if expand('%:t') =~ 'test_*'
  setlocal makeprg=/usr/local/bin/asdf\ exec\ pytest\ %
else
  setlocal makeprg=/usr/local/bin/asdf\ exec\ pytest

  let b:ale_linters += ['mypy']
endif
