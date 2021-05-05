" vimr config

let fontname = 'InputMono-Thin'

if hostname()[0:2] ==? 'GDS'
  VimRSetFontAndSize fontname, 14
else
  VimRSetFontAndSize fontname, 14
endif

VimRHideTools
VimRHideToolButtons

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
  au WinNew,FocusGained * call DarkMode()
augroup END
