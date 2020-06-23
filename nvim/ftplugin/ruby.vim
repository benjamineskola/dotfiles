let b:ale_fixers = ['rubocop']
let b:ale_ruby_rubocop_options = '--except Rails'

nnoremap <leader>r :call LanguageClient#textDocument_rename()<CR>


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
