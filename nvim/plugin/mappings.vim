let mapleader = ','

nnoremap <Leader>l <Cmd>nohl<CR>

nnoremap <Leader>u <Cmd>MundoToggle<CR>

nnoremap <Leader>f <Cmd>Files<CR>
nnoremap <expr> <Leader>g "<Cmd>Rg " . input('Find word: ') . "<CR>"
nnoremap <expr> <Leader>G "<Cmd>Rg " . expand('<cword>') . "<CR>"

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
