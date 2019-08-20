let mapleader = ','

nmap <C-l> :nohl<CR>:redraw<CR>

nnoremap <leader>u <cmd>GundoToggle<CR>

cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

map Q gq

nmap <leader>d <Plug>DashSearch

nmap <silent> <leader>tn <cmd>TestNearest<CR>
nmap <silent> <leader>tf <cmd>TestFile<CR>
nmap <silent> <leader>ts <cmd>TestSuite<CR>
nmap <silent> <leader>tl <cmd>TestLast<CR>
nmap <silent> <leader>tv <cmd>TestVisit<CR>

cnoremap        <C-A> <Home>

" reformat selection/paragraph
vnoremap Q gw
nnoremap Q gwap

" close buffer/window
nnoremap <leader>q <cmd>bd<CR>
nnoremap <leader>Q <cmd>q<CR>

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
nmap <leader>vv <cmd>edit $MYVIMRC<CR>
nmap <expr> <leader>vp '<cmd>edit ' . stdpath('config') . '/plugins.vim<CR>'
nmap <expr> <leader>vm '<cmd>edit ' . stdpath('config') . '/plugin/mappings.vim<CR>'

nmap <leader>sv <cmd>source $MYVIMRC<CR>
nmap <leader>sp <cmd>runtime plugins.vim<CR>
nmap <leader>sm <cmd>runtime plugin/mappings.vim<CR>

" prefer buffers to tabs
cnoreabbrev tabedit edit
cnoreabbrev tabe e
