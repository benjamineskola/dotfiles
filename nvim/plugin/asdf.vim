if exists('g:loaded_asdf')
  finish
endif
let g:loaded_asdf = 1

if system('uname -p') ==# 'arm'
  let homebrew_prefix = '/opt/homebrew'
else
  let homebrew_prefix = '/usr/local'
endif

if !filereadable(homebrew_prefix . '/opt/asdf/asdf.sh')
  finish
endif

let &shell = &shell . ' -i'

let $ASDF_CONFIG_FILE = $XDG_CONFIG_HOME . '/asdfrc'
let $ASDF_DATA_DIR = $XDG_DATA_HOME . '/asdf'
let $ASDF_DEFAULT_TOOL_VERSIONS_FILENAME = $XDG_CONFIG_HOME . '/tool-versions'
let $ASDF_DIR = homebrew_prefix . '/opt/asdf'
let $ENV = homebrew_prefix . '/opt/asdf/asdf.sh'

let $PYTHONPATH = expand($ASDF_DATA_DIR . '/installs/python/3.*/lib/python3.*/site-packages')
let $PATH = $ASDF_DATA_DIR . '/shims:' . $PATH

let g:loaded_python_provider = 0
let g:python3_host_prog = $ASDF_DATA_DIR . '/shims/python'
let g:ruby_host_prog = $ASDF_DATA_DIR . '/shims/ruby'
