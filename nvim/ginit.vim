" vimr config

VimRSetFontAndSize 'FiraCode-Light', 14
VimRHideTools
VimRHideToolButtons

cnoreabbrev bd Bdelete
cnoreabbrev q Bdelete
cnoreabbrev qa only!\|bufdo Bdelete
cnoreabbrev qall only!\|bufdo Bdelete
cnoreabbrev qa! only!\|bufdo Bdelete!
cnoreabbrev qall! only!\|bufdo Bdelete!
cnoreabbrev wq w\|Bdelete
cnoreabbrev wqa wa\|only!\|bufdo Bdelete
cnoreabbrev wqall wa\|only!\|bufdo Bdelete
cnoreabbrev wqa! wa!\|only!\|bufdo Bdelete!
cnoreabbrev wqall! wa!\|only!\|bufdo Bdelete!
cnoreabbrev x up
cnoreabbrev xit update

nnoremap ZZ <Cmd>update<CR>
nnoremap ZQ <Cmd>only!\|bufdo Bdelete!<CR>
