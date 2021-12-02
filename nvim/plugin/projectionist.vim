if !exists('g:projectionist_heuristics')
  let g:projectionist_heuristics = {}
endif

" Django
let g:projectionist_heuristics['Pipfile|requirements.txt|pyproject.toml'] = {
  \ '*/views/__init__.py': {
  \    'type': 'view',
  \    'alternate': 'tests/test_views.py',
  \ },
  \ '**/views/*.py': {
  \    'type': 'view',
  \    'alternate': '{dirname}/tests/views/test_{basename}_view.py',
  \ },
  \ '*/views.py': {
  \    'type': 'view',
  \    'alternate': '{dirname}/tests/test_views.py',
  \ },
  \ '*/models/__init__.py': {
  \    'type': 'model',
  \    'alternate': '{dirname}/tests/test_models.py',
  \ },
  \ '**/models/*.py': {
  \    'type': 'model',
  \    'alternate': '{dirname}/tests/models/test_{basename}.py',
  \ },
  \ '*/models.py': {
  \    'type': 'model',
  \    'alternate': '{dirname}/tests/test_models.py',
  \ },
  \ '**/tests/views/test_*_view.py': {
  \    'type': 'test',
  \    'alternate': '{dirname}/views/{basename}.py',
  \ },
  \ '**/tests/views/test_*.py': {
  \    'type': 'test',
  \    'alternate': '{dirname}/views/{basename}.py',
  \ },
  \ '**/tests/models/test_*.py': {
  \    'type': 'test',
  \    'alternate': '{dirname}/models/{basename}.py',
  \ },
  \ '*.py': {
  \    'alternate': '{project}/tests/test_{basename}.py',
  \    'template': ['class {basename|camelcase|capitalize}:', '    pass'],
  \ },
  \ '**/tests/test_*.py': {
  \    'type': 'test',
  \    'alternate': '{}.py',
  \ },
\ }


" Rails, mainly
let g:projectionist_heuristics['bin/rails|Gemfile'] = {
  \ '*.rb': {
  \   'template': ['class {camelcase|capitalize|basename}', 'end'],
  \ },
  \ 'app/models/*.rb': {
  \   'type': 'model',
  \   'alternate': ['spec/models/{}_spec.rb', 'spec/{}.rb'],
  \   'template': ['class {camelcase|capitalize|colons} < ApplicationRecord', 'end']
  \ },
  \ 'spec/models/*_spec.rb': {
  \   'type': 'test',
  \   'alternate': 'app/models/{}.rb',
  \ },
  \ 'app/controllers/*.rb': {
  \   'type': 'controller',
  \   'alternate': ['spec/controllers/{}_spec.rb', 'spec/controllers/{}_controller_spec.rb', 'spec/{}_controller_spec.rb', 'spec/{}_spec.rb'],
  \   'template': ['class {camelcase|capitalize|colons} < ApplicationController', 'end']
  \ },
  \ 'spec/controllers/*_spec.rb': {
  \   'type': 'test',
  \   'alternate': 'app/controllers/{}.rb',
  \ },
  \ 'lib/*.rb': {
  \   'type': 'lib',
  \   'alternate': ['spec/lib/{}_spec.rb', 'spec/{}_spec.rb'],
  \   'template': ['class {camelcase|capitalize|colons}', 'end'],
  \ },
  \ 'spec/lib/*_spec.rb': {
  \   'type': 'test',
  \   'alternate': 'lib/{}.rb',
  \ },
  \ 'spec/*_spec.rb': {
  \   'template': ['require "rails_helper"', '', 'Rspec.describe {camelcase|capitalize} do', 'end'],
  \ },
\ }

" Defaults: shebangs
let g:projectionist_heuristics['*'] = {
  \ '*.py': {
  \   'template': ['#!/usr/bin/env python', '', 'class {basename|camelcase|capitalize}:', '    pass', '', '', 'if __name__ == "__main__":', '    pass'],
  \ },
  \ '*.rb': {
  \   'template': ['#!/usr/bin/env ruby', 'class {camelcase|capitalize|basename}', 'end']
  \ },
  \ '*.sh': {
  \   'template': ['#!/bin/sh','set -e']
  \ },
  \ '*.vim': {
  \   'template': [ "if exists('g:loaded_{}')", '  finish', 'endif', 'let g:loaded_{} = 1' ]
  \ },
\ }
