let b:ale_fixers = ['autopep8', 'isort']
let g:neomake_python_exe = '/usr/local/bin/python3'
let g:neomake_python_enabled_makers = ['python'] + neomake#makers#ft#python#EnabledMakers()[2:] + ['mypy']
let g:neomake_python_mypy_args = [
                \ '--show-column-numbers',
                \ '--check-untyped-defs',
                \ '--ignore-missing-imports',
                \ '--strict',
                \ ]
