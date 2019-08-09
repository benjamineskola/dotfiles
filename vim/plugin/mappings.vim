let mapleader = ','

nmap <C-l> :nohl<CR>:redraw<CR>

let g:nremap = {']t': '', '[t': ''}
map ]t gt
map [t gT

nnoremap <leader>u :GundoToggle<CR>

imap § <ESC>

cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

map Q gq

nmap <leader>d <Plug>DashSearch

nmap <silent> <leader>n :TestNearest<CR>
nmap <silent> <leader>m :TestFile<CR>
nmap <silent> <leader>M :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>v :TestVisit<CR>
