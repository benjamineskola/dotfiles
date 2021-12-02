if exists('b:govuk_project')
  let b:ale_fixers = ['rubocop']
  let b:ale_ruby_rubocop_options = '--except Rails'
else
  let b:ale_fixers = ['standardrb']
endif
let b:ale_linters = b:ale_fixers

let b:ale_command_wrapper = 'asdf env ruby'
if FindInParent('Gemfile.lock')
  let b:ale_command_wrapper .= ' bundle exec'
endif

let g:LanguageClient_serverCommands['ruby'] = [ $ASDF_DATA_DIR . '/shims/solargraph', 'stdio']

nnoremap <buffer> <silent> <localleader>r :call LanguageClient#textDocument_rename()<CR>
nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
