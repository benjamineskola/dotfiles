let mapleader = ','

nnoremap <Leader>l <Cmd>nohl<CR>

nnoremap <Leader>u <Cmd>MundoToggle<CR>

nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <Leader>f <cmd>Telescope find_files<cr>
nnoremap <Leader>g <cmd>Telescope live_grep<cr>
nnoremap <Leader>o <cmd>Telescope oldfiles<cr>
nnoremap <Leader>x <cmd>Telescope lsp_code_actions<cr>
nnoremap <leader>c <cmd>lua require('telescope.builtin').find_files({find_command={"sh", "-c", "fd --type d --max-depth 1 . $HOME/Code $HOME/govuk; echo $XDG_CONFIG_HOME"}})<cr>

vnoremap <Leader>x <cmd>Telescope lsp_range_code_actions<cr>


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
nmap <Leader>vv <Cmd>edit $MYVIMRC<CR>
nmap <expr> <Leader>vp '<Cmd>edit ' . stdpath('config') . '/lua/plugins.lua<CR>'
nmap <expr> <Leader>vm '<Cmd>edit ' . stdpath('config') . '/plugin/mappings.vim<CR>'
nnoremap <expr> <Leader>vf '<Cmd>edit ' . stdpath('config') . '/ftplugin/' . &filetype . '.vim<CR>'

nnoremap <Leader>sv <Cmd>source $MYVIMRC<CR>
nnoremap <Leader>sp <Cmd>runtime plugins.vim<CR>
nnoremap <Leader>sm <Cmd>runtime plugin/mappings.vim<CR>

" run current file in a terminal

nnoremap <Leader>vr <Cmd>belowright split +terminal\ %<CR>
nnoremap <expr> <Leader>vR "<Cmd>belowright split +terminal\\ %\\ " . join(split(input('Parameters: '), ' '), '\ ') . "<CR>"

" kill buffer with cmd-w
nnoremap <D-w> <Cmd>Bdelete<CR>
nnoremap <D-M-w> <Cmd>Bdelete!<CR>
