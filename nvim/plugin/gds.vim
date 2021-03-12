if hostname()[0:2] ==? 'GDS'
  function! SetGovukProject() abort
    let govuk_project = matchlist(expand('%:p:h'), '/govuk/\([^/]\+\)')
    if len(govuk_project) > 1
      let b:govuk_project = govuk_project[1]
    end
    unlet govuk_project
  endfunction
  augroup govuk
    autocmd BufEnter,BufNewFile */govuk/* execute(SetGovukProject())
  augroup END

  function! GovukDockerTransform(cmd) abort
    if exists('b:govuk_project')
      if filereadable($HOME . '/govuk/govuk-docker/projects/' . b:govuk_project . '/docker-compose.yml')
        return 'govuk-docker-run bundle exec ' . a:cmd
      endif
    endif
    return a:cmd
  endfunction
  let g:test#custom_transformations = {'govuk-docker': function('GovukDockerTransform')}

  let g:test#transformation = 'govuk-docker'
endif
