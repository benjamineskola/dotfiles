let g:fzf_action = {'enter': 'tab split'}
let $FZF_DEFAULT_COMMAND='fd -H -E "{.git,.Trash,Library,Movies,Music,Pictures}"'

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden -g !"{.git,.Trash,Library,Movies,Music,Pictures}" --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
