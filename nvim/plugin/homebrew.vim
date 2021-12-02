if exists('g:loaded_homebrew')
  finish
endif
let g:loaded_homebrew = 1

if !empty($HOMEBREW_PREFIX)
  let g:homebrew_prefix = $HOMEBREW_PREFIX
elseif systemlist('uname -p')[0] ==# 'arm'
  let g:homebrew_prefix = '/opt/homebrew'
else
  let g:homebrew_prefix = '/usr/local'
endif
