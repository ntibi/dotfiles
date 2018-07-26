atom.keymaps.keyBindings = atom.keymaps.keyBindings.filter((binding) ->
  not (binding.keystrokes.indexOf("ctrl-k") is 0 && binding.source.startsWith("core:"))
  )

colors = [
  "#9999bb"
  "#bb99b4"
  "#bba699"
  "#a6bb99"
  "#99bbb4"
  "#e0d0a0"
  "#a3e0a0"
  "#a0d6e0"
  "#b6a0e0"
  "#e0a0bc"
  "#a7c0b9"
  "#a7aac0"
  "#c0a7bd"
  "#c0afa7"
  "#b3c0a7"
]

update_rainbow_identifiers = ->
  # for elt in atom.document.getElementsByClassName("syntax--other")
  for elt in atom.document.querySelectorAll(".syntax--other", ".syntax--meta", ".syntax--variable")
    elt.style.color = colors[Array.from(elt.textContent).reduce(((acc, v) -> acc + v.charCodeAt(0)), 0) % colors.length]

atom.workspace.observeTextEditors((editor) ->
  do update_rainbow_identifiers
  editor.onDidStopChanging update_rainbow_identifiers # (https://atom.io/docs/api/v1.2.1/TextEditor#instance-onDidChange)
  )
