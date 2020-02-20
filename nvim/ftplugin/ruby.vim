let b:ale_fixers = ['rubocop']

nnoremap <leader>r :call LanguageClient#textDocument_rename()<CR>


let g:projectionist_heuristics = {
  \ 'app/|lib/|spec/': {
    \   'app/models/*.rb': {
    \      'type': 'model',
    \      'alternate': ['spec/models/{}_spec.rb', 'spec/{}.rb'],
    \   },
    \   'spec/models/*_spec.rb': {
    \      'type': 'test',
    \      'alternate': 'app/models/{}.rb',
    \      'template': ['Rspec.describe {camelcase} do', 'end'],
    \   },
    \   'app/controllers/*.rb': {
    \      'type': 'controller',
    \      'alternate': ['spec/controllers/{}_spec.rb', 'spec/controllers/{}_controller_spec.rb', 'spec/{}_controller_spec.rb', 'spec/{}_spec.rb'],
    \   },
    \   'spec/controllers/*_spec.rb': {
    \      'type': 'test',
    \      'alternate': 'app/controllers/{}.rb',
    \      'template': ['Rspec.describe {camelcase} do', 'end'],
    \   },
    \   'lib/*.rb': {
    \      'type': 'lib',
    \      'alternate': ['spec/lib/{}_spec.rb', 'spec/{}_spec.rb'],
    \   },
    \   'spec/lib/*_spec.rb': {
    \      'type': 'test',
    \      'alternate': 'lib/{}.rb',
    \      'template': ['Rspec.describe {camelcase} do', 'end'],
    \   },
  \ }
\ }
