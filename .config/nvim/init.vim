if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dearrrfish/vim-applescript'
Plug 'derekwyatt/vim-scala'
Plug 'editorconfig/editorconfig-vim'
Plug 'icymind/NeoSolarized'
Plug 'neomake/neomake'
Plug 'pangloss/vim-javascript'
Plug 'Raimondi/delimitMate'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-ruby/vim-ruby'
Plug 'rust-lang/rust.vim'
call plug#end()

set hidden
set ignorecase smartcase
set modeline
set number
set pastetoggle=<F10>

set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

" appearance.
let fg_bg = split($COLORFGBG, ";")

set termguicolors
if len(fg_bg) > 0 && (fg_bg[1] == 8 || fg_bg[1] == 15)
  colo neosolarized
else
  colo base16-materia
end
syntax on

" filetype stuff.
filetype plugin indent on
let g:is_posix = 1 " /bin/sh is always POSIX, because what the fuck.

" plugin settings
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'
let g:EditorConfig_core_mode = 'external_command'

let g:ctrlp_user_command = 'ag --literal --files-with-matches --nocolor --hidden --filename-pattern "" --ignore .git --ignore .hg --ignore Library %s'

let g:python_host_prog = '/usr/local/bin/python'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline_powerline_fonts = 1

call neomake#configure#automake('nrwi', 500)
autocmd! BufReadPost,BufWritePost,BufWinEnter * Neomake
let g:neomake_open_list = 2
let g:neomake_rubocop_exe = expand("/Users/ben/.gem/ruby/$RUBY_VERSION/bin/rubocop")

" mappings
let mapleader= ","

nmap <C-l> :nohl<CR>:redraw<CR>

map <M-'> cs"'
map <M-"> cs'"

map <C-Tab> gt
nmap <Tab> gt
map <C-S-Tab> gT
nmap <S-Tab> gT
let g:nremap = {"]t": "", "[t": ""}
map ]t gt
map [t gT

nnoremap <F5> :GundoToggle<CR>

map <leader>cc gcc
map <leader>cu gcc

if has ('gui_vimr')
  for i in range(1, 9)
    execute "nnoremap <D-" . i . "> " . i . "gt"
  endfor
  nnoremap <silent><D-0> :tablast<CR>
end
