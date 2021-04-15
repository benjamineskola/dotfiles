" vimr config

let fontname = 'InputMono-Thin'

if hostname()[0:2] ==? 'GDS'
  VimRSetFontAndSize fontname, 14
else
  VimRSetFontAndSize fontname, 14
endif

VimRHideTools
VimRHideToolButtons
