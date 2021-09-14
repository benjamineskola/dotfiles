let $FZF_DEFAULT_COMMAND='fd -t f -H -E "{.git,.Trash,Library,Movies,Music,Pictures}"'

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

command! -bang -nargs=? -complete=dir Dirs
    \ call fzf#vim#grep('echo $HOME/.config; fd -E .git -d 1 --type d . $HOME/Code $HOME/govuk',
      \ 0,
      \{'options': ['--prompt=Project> ', '--info=inline', '--preview', '$XDG_CONFIG_HOME/vim/plugged/fzf.vim/bin/preview.sh {}/README.md'], 'sink': 'cd'}, <bang>0)
