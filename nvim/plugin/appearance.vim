set termguicolors

let dark_mode = trim(system('osascript -l JavaScript -e "Application(\"System Events\").appearancePreferences.darkMode.get()"'))

if dark_mode ==# 'true'
  set background=dark
else
  set background=light
endif

colo gruvbox

highlight SpellBad guisp=red
