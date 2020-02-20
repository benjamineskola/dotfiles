let b:ale_fixers = ['rubocop']

nnoremap <leader>r :call LanguageClient#textDocument_rename()<CR>


let g:projectionist_heuristics = {
  \ 'app/|lib/|spec/': {
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
