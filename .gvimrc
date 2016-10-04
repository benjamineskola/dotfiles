set guifont=Source_Code_Pro:h12 
let  g:airline_powerline_fonts=1 " use powerline fonts

if has("gui_macvim")
  macmenu File.Print key=<nop>
  map <D-p> :CommandT<CR>
endif
