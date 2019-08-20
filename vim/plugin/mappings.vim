let mapleader = ','

nmap <C-l> :nohl<CR>:redraw<CR>

let g:nremap = {']t': '', '[t': ''}
map ]t gt
map [t gT

nnoremap <leader>u <cmd>GundoToggle<CR>

cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

map Q gq

nmap <leader>d <Plug>DashSearch

nmap <silent> <leader>n <cmd>TestNearest<CR>
nmap <silent> <leader>m <cmd>TestFile<CR>
nmap <silent> <leader>M <cmd>TestSuite<CR>
nmap <silent> <leader>l <cmd>TestLast<CR>
nmap <silent> <leader>v <cmd>TestVisit<CR>

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
