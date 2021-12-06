let b:ale_linters = ['golangci-lint', 'gopls']
let b:ale_fixers = ['goimports', 'golines', {buffer -> { 'command': 'gofumpt' }}]
let b:ale_go_golangci_lint_options = '--enable-all --disable gci'

set tabstop=4
