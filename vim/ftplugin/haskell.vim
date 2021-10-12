set expandtab
set shiftwidth=2
set softtabstop=2

let b:ale_fixers = ['brittany']

if FindInGitRoot('stack.yaml')
  let b:ale_linters = ['stack_build', 'stack_ghc']
elseif FindInGitRoot('*.cabal')
  let b:ale_linters = ['cabal_ghc']
else
  let b:ale_linters = ['ghc']
endif

let b:ale_linters += ['hie', 'hlint', 'hls']
