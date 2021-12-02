let b:ale_linters = ['golangci-lint', 'gopls']
let b:ale_fixers = ['goimports', 'golines', {buffer -> { 'command': 'gofumpt' }}]
let b:ale_go_golangci_lint_options = '--enable-all --disable gci'
let g:LanguageClient_serverCommands['go'] = [$ASDF_DATA_DIR . '/shims/gopls']

set tabstop=4
