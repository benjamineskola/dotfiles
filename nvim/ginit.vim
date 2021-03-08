" vimr config

let fontname = 'BlexMono Nerd Font Mono'

if hostname()[0:2] ==? 'GDS'
  VimRSetFontAndSize fontname, 13
else
  VimRSetFontAndSize fontname, 14
endif

VimRHideTools
VimRHideToolButtons
