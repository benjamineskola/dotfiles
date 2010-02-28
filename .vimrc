syntax on
filetype plugin indent on
set autoindent smartindent
set noexpandtab ts=8 sw=8
set backspace=indent,eol,start
set statusline=%<%f\ %h%m%y%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2
set tabpagemax=99
set encoding=utf-8

if $TERM == "rxvt"
    " identifying as rxvt means freebsd, which means 256-colour support.
    let &t_Co = 256
endif
set background=dark
colorscheme xterm16

highlight Tabs cterm=standout
highlight TabLine cterm=reverse

map <Tab> :tabnext<CR>
map <S-Tab> :tabprev<CR>

" Show leading whitespace that includes tabs, and trailing whitespace.
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/

" cd to current directory for every buffer, except ones in tempdirs.
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' && expand("%:p:h") !~ $TMP | lcd %:p:h | endif

let g:tex_flavor='latex'

if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif

let $PAGER=''

if has("omnifunc")
    let g:SuperTabDefaultCompletionTypeDiscovery = "&omnifunc:<C-X><C-O>,&completefunc:<C-X><C-U>"
endif

let g:SuperTabMappingForward = '<nul>'
let g:SuperTabMappingBackward = '<s-nul>'
set ofu=syntaxcomplete#Complete

let g:EnhCommentifyPretty = "yes"
let g:EnhCommentifyUseBlockIndent = "yes"
let g:EnhCommentifyMultiPartBlocks = "yes"
let g:EnhCommentifyUseSyntax = "yes"
