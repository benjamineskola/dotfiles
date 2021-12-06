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
