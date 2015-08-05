atom.workspace.observeTextEditors (editor) ->
  console.log editor.getPath()
  if editor.getPath().match(/\/\.zsh/)
    editor.setGrammar g for g in atom.grammars.getGrammars() when g.name is "Shell Script"
