if exists('g:loaded_asdf')
  finish
endif
let g:loaded_asdf = 1

if !filereadable('/usr/local/opt/asdf/asdf.sh')
  finish
endif

let &shell = &shell . ' -i'

let $ASDF_CONFIG_FILE = $XDG_CONFIG_HOME . '/asdfrc'
let $ASDF_DATA_DIR = $XDG_DATA_HOME . '/asdf'
let $ASDF_DEFAULT_TOOL_VERSIONS_FILENAME = $XDG_CONFIG_HOME . '/tool-versions'
let $ASDF_DIR = '/usr/local/opt/asdf'
let $ENV = '/usr/local/opt/asdf/asdf.sh'

let $PYTHONPATH = expand($ASDF_DATA_DIR . '/installs/python/3.*/lib/python3.*/site-packages')
let $PATH = $ASDF_DATA_DIR . '/shims:' . $PATH

if has('nvim')
  let g:python3_host_prog = $ASDF_DATA_DIR . '/shims/python'
  let g:ruby_host_prog = $ASDF_DATA_DIR . '/shims/ruby'
endif
