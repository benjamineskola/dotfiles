let g:fzf_action = {'enter': 'tab split', 'ctrl-x': 'split', 'ctrl-v': 'vsplit'}
let $FZF_DEFAULT_COMMAND='fd -H -E "{.git,.Trash,Library,Movies,Music,Pictures}"'

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

command! -bang -nargs=? -complete=dir Dirs
    \ call fzf#vim#grep('fd -E .git -d 1 --type d . $HOME/.config $HOME/Code $HOME/govuk',
      \ 0,
      \ fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline'], 'sink': 'cd'}), <bang>0)
