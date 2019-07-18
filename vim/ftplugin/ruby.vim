let b:ale_fixers = ['rubocop']

if empty(bundler#project())
  setlocal makeprg=/usr/local/bin/asdf\ exec\ rspec
else
  setlocal makeprg=/usr/local/bin/asdf\ exec\ bundle\ exec\ rspec
endif
if expand('%:t') =~ 'spec_*.rb\|*_spec.rb'
  let &l:makeprg=&makeprg . ' %'
endif
