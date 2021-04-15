if has('gui_vimr')
  set termguicolors
endif

colo gruvbox
let g:airline_theme = 'gruvbox'

highlight SpellBad guisp=red

function! DarkMode()
  let dark_mode = trim(system('osascript -l JavaScript -e "Application(\"System Events\").appearancePreferences.darkMode.get()"'))
  if dark_mode ==# 'true'
    set background=dark
  else
    set background=light
  endif
  AirlineRefresh
endfunction
augroup darkmode
  au CursorHold * call DarkMode()
  au FocusGained * call DarkMode()
augroup END
