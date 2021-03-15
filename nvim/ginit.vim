" vimr config

let fontname = 'IosevkaNerdFontCompleteM-Extralight'

if hostname()[0:2] ==? 'GDS'
  VimRSetFontAndSize fontname, 14
else
  VimRSetFontAndSize fontname, 15
endif

VimRHideTools
VimRHideToolButtons
