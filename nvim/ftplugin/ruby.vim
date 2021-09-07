if exists('b:govuk_project')
  let b:ale_fixers = ['rubocop']
  let b:ale_ruby_rubocop_options = '--except Rails'
else
  let b:ale_fixers = ['standardrb']
endif
let b:ale_linters = b:ale_fixers

let b:ale_command_wrapper = 'asdf env ruby'
let pattern = '%:h'
while expand(pattern) !=? '/'
  if filereadable(expand(pattern) . '/Gemfile.lock')
    let b:ale_command_wrapper .= ' bundle exec'
    break
  endif
  let pattern = pattern . ':h'
endwhile
unlet pattern

let g:LanguageClient_serverCommands['ruby'] = [ $ASDF_DATA_DIR . '/shims/solargraph', 'stdio']

nnoremap <buffer> <silent> <localleader>r :call LanguageClient#textDocument_rename()<CR>
nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>

let g:projectionist_heuristics = {
  \ 'bin/rails|Gemfile': {
    \   '*.rb': {
    \      'template': ['class {camelcase|capitalize|basename}', 'end'],
    \   },
    \   'app/models/*.rb': {
    \      'type': 'model',
    \      'alternate': ['spec/models/{}_spec.rb', 'spec/{}.rb'],
    \      'template': ['class {camelcase|capitalize|colons} < ApplicationRecord', 'end']
    \   },
    \   'spec/models/*_spec.rb': {
    \      'type': 'test',
    \      'alternate': 'app/models/{}.rb',
    \   },
    \   'app/controllers/*.rb': {
    \      'type': 'controller',
    \      'alternate': ['spec/controllers/{}_spec.rb', 'spec/controllers/{}_controller_spec.rb', 'spec/{}_controller_spec.rb', 'spec/{}_spec.rb'],
    \      'template': ['class {camelcase|capitalize|colons} < ApplicationController', 'end']
    \   },
    \   'spec/controllers/*_spec.rb': {
    \      'type': 'test',
    \      'alternate': 'app/controllers/{}.rb',
    \   },
    \   'lib/*.rb': {
    \      'type': 'lib',
    \      'alternate': ['spec/lib/{}_spec.rb', 'spec/{}_spec.rb'],
    \      'template': ['class {camelcase|capitalize|colons}', 'end'],
    \   },
    \   'spec/lib/*_spec.rb': {
    \      'type': 'test',
    \      'alternate': 'lib/{}.rb',
    \   },
    \   'spec/*_spec.rb': {
    \      'template': ['require "rails_helper"', '', 'Rspec.describe {camelcase|capitalize} do', 'end'],
    \   },
  \ },
\ }
