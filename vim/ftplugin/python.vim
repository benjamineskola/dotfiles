let b:ale_fixers = ['black', 'isort']
let g:neomake_python_exe = '/usr/local/bin/python3'
let g:neomake_python_enabled_makers = ['python', 'flake8', 'mypy']
let g:neomake_python_mypy_args = [
                \ '--show-column-numbers',
                \ '--check-untyped-defs',
                \ '--ignore-missing-imports',
                \ '--strict',
                \ ]
