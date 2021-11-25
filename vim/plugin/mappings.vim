let mapleader = ','

nnoremap <Leader>l <Cmd>nohl<CR>

nnoremap <Leader>u <Cmd>MundoToggle<CR>

nnoremap <Leader>f <Cmd>Files<CR>
nnoremap <Leader>g <Cmd>Rg<CR>
nnoremap <expr> <Leader>G "<Cmd>Rg " . expand('<cword>') . "<CR>"
nnoremap <Leader>c <Cmd>Dirs<CR>

" avoid ex mode
nnoremap Q <nop>

nnoremap <Leader>d <Plug>DashSearch

nnoremap <silent> <Leader>tn <Cmd>TestNearest<CR>
nnoremap <silent> <Leader>tf <Cmd>TestFile<CR>
nnoremap <silent> <Leader>ts <Cmd>TestSuite<CR>
nnoremap <silent> <Leader>tl <Cmd>TestLast<CR>
nnoremap <silent> <Leader>tv <Cmd>TestVisit<CR>

cnoremap <C-A> <Home>

" reformat selection/paragraph
vnoremap Q gw
nnoremap Q gwap " Overwrites default binding for Ex mode

" close buffer/window
nnoremap <Leader>q <Cmd>bd<CR>
nnoremap <Leader>Q <Cmd>q<CR>

" better regexes for search
nnoremap / /\v
vnoremap / /\v
cnoreabbrev s sm
cnoreabbrev %s %sm
cnoreabbrev '<,'>s '<,'>sm

" allow semicolon instead of colon for command mode
nnoremap ; :

" edit/source vim configs
nnoremap <Leader>vv <Cmd>edit $MYVIMRC<CR>
nnoremap <expr> <Leader>vp '<Cmd>edit ' . $XDG_CONFIG_HOME . '/vim/plugins.vim<CR>'
nnoremap <expr> <Leader>vm '<Cmd>edit ' . $XDG_CONFIG_HOME . '/vim/plugin/mappings.vim<CR>'
nnoremap <expr> <Leader>vf '<Cmd>edit ' . $XDG_CONFIG_HOME . '/vim/ftplugin/' . &filetype . '.vim<CR>'

nnoremap <Leader>sv <Cmd>source $MYVIMRC<CR>
nnoremap <Leader>sp <Cmd>runtime plugins.vim<CR>
nnoremap <Leader>sm <Cmd>runtime plugin/mappings.vim<CR>

" run current file in a terminal

nnoremap <Leader>vr <Cmd>belowright split +terminal\ %<CR>
nnoremap <expr> <Leader>vR "<Cmd>belowright split +terminal\\ %\\ " . join(split(input('Parameters: '), ' '), '\ ') . "<CR>"

" kill buffer with cmd-w
nnoremap <D-w> <Cmd>Bdelete<CR>
nnoremap <D-M-w> <Cmd>Bdelete!<CR>
