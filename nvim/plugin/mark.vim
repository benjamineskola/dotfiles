function! SetGMark(mark, filename, line_nr)
    let l:mybuf = bufnr(a:filename, 1)
    call setpos("'".a:mark, [l:mybuf, a:line_nr, 1, 0])
endf

call SetGMark('V', '~/.config/nvim/init.lua', 1)
call SetGMark('M', '~/.config/nvim/lua/config/mappings.lua', 1)
call SetGMark('P', '~/.config/nvim/lua/config/plugins.lua', 1)
