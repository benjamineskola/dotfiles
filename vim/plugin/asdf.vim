if exists('g:loaded_asdf')
  finish
endif
let g:loaded_asdf = 1

if systemlist('uname -p')[0] ==# 'arm'
  let homebrew_prefix = '/opt/homebrew'
else
  let homebrew_prefix = '/usr/local'
endif

if !filereadable(homebrew_prefix . '/opt/asdf/asdf.sh')
  finish
endif

" let &shellcmdflag = '-i -c'

if empty($ASDF_DIR)
  let $ASDF_CONFIG_FILE = $XDG_CONFIG_HOME . '/asdfrc'
  let $ASDF_DATA_DIR = $XDG_DATA_HOME . '/asdf'
  let $ASDF_DEFAULT_TOOL_VERSIONS_FILENAME = $XDG_CONFIG_HOME . '/tool-versions'
  let $ASDF_DIR = homebrew_prefix . '/opt/asdf/libexec'
  " let $ENV = homebrew_prefix . '/opt/asdf/asdf.sh'

  let $PYTHONPATH = expand($ASDF_DATA_DIR . '/installs/python/3.*/lib/python3.*/site-packages')
  let $PATH = $ASDF_DATA_DIR . '/shims:' . $PATH
endif

set pythonthreehome=$ASDF_DATA_DIR/installs/python/3.9.7
