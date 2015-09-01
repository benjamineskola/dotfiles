atom.workspace.observeTextEditors (editor) ->
  grammar = atom.grammars.grammarForScopeName('source.shell')
  if editor.getPath().startsWith(process.env.HOME + '/.zsh')
    editor.setGrammar grammar
