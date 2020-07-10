let b:ale_fixers = ['goimports']

set tabstop=4

if expand($GOPATH) ==# ''
  let $GOPATH=$HOME . '/Code/go'
endif
if $PATH !~ $GOPATH
  let $PATH=$PATH . ':' . $GOPATH . '/bin'
endif
