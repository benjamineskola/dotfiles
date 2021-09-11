let mapleader = ','

nnoremap <Leader>l <Cmd>nohl<CR>

nnoremap <Leader>u <Cmd>MundoToggle<CR>

nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>c <cmd>:lua require'telescope'.extensions.project.project{ display_type = 'full' }<cr>

map Q gq

nmap <Leader>d <Plug>DashSearch

nmap <silent> <Leader>tn <Cmd>TestNearest<CR>
nmap <silent> <Leader>tf <Cmd>TestFile<CR>
nmap <silent> <Leader>ts <Cmd>TestSuite<CR>
nmap <silent> <Leader>tl <Cmd>TestLast<CR>
nmap <silent> <Leader>tv <Cmd>TestVisit<CR>

cnoremap        <C-A> <Home>

" reformat selection/paragraph
vnoremap Q gw
nnoremap Q gwap

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

" avoid ex mode
nmap Q <nop>

" edit/source vim configs
nmap <Leader>vv <Cmd>edit $MYVIMRC<CR>
nmap <expr> <Leader>vp '<Cmd>edit ' . stdpath('config') . '/plugins.vim<CR>'
nmap <expr> <Leader>vm '<Cmd>edit ' . stdpath('config') . '/plugin/mappings.vim<CR>'

nmap <Leader>sv <Cmd>source $MYVIMRC<CR>
nmap <Leader>sp <Cmd>runtime plugins.vim<CR>
nmap <Leader>sm <Cmd>runtime plugin/mappings.vim<CR>

" run current file in a terminal

nnoremap <Leader>vr <Cmd>belowright split +terminal\ %<CR>
nnoremap <expr> <Leader>vR "<Cmd>belowright split +terminal\\ %\\ " . join(split(input('Parameters: '), ' '), '\ ') . "<CR>"

" kill buffer with cmd-w
nnoremap <D-w> <Cmd>bdelete<CR>
nnoremap <D-M-w> <Cmd>bdelete!<CR>
