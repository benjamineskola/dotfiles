atom.workspace.observeTextEditors (editor) ->
  grammar = (g for g in atom.grammars.getGrammars() when g.scopeName is "source.shell")[0]
  if editor.getPath().match(/\/\.zsh/)
    editor.setGrammar grammar
