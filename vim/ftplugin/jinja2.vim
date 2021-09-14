  call ale#linter#Define('jinja2', {
  \   'name': 'curlylint',
  \   'executable': 'curlylint',
  \   'command': '%e --quiet --rule "indent: ' . &shiftwidth . '" %t | sed -E "s/[[:cntrl:]]\[[0-9]{1,3}m//g; s/^/-:/; s/	+(.*)	(.*)$/: \2: \1/;" | tail -n +2',
  \   'callback': 'ale#handlers#gcc#HandleGCCFormat',
  \   'lint_file': 1,
  \})

let b:ale_fixers = []
let b:ale_linters = ['curlylint']

let b:endwise_addition = '{% end& %}'
let b:endwise_words = 'autoescape,block,cache,call,filter,for,if,macro,raw,set,trans,with'
let b:endwise_syngroups = 'jinjaTagBlock,jinjaStatement'

setlocal commentstring={#\ %s\ #}
