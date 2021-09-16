if empty(glob($XDG_CONFIG_HOME . '/vim/autoload/plug.vim'))
  silent !curl -fLo $XDG_CONFIG_HOME/vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup vimplug_install
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

runtime autoload/plug.vim

runtime plugin/asdf.vim
call plug#begin()
  Plug g:homebrew_prefix . '/opt/fzf'

  Plug 'benjamineskola/vim-applescript'
  Plug 'christoomey/vim-sort-motion' | Plug 'kana/vim-textobj-indent'
  Plug 'davidhalter/jedi-vim'
  Plug 'ervandew/supertab'
  Plug 'janko/vim-test'
  Plug 'junegunn/fzf.vim'
  Plug 'Konfekt/FastFold'
  Plug 'markonm/traces.vim'
  Plug 'mhinz/vim-signify'
  Plug 'morhetz/gruvbox'
  Plug 'nelstrom/vim-textobj-rubyblock' | Plug 'kana/vim-textobj-user'
  Plug 'Raimondi/delimitMate'
  Plug 'rizzatti/dash.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'simnalamburt/vim-mundo'
  Plug 'sjl/splice.vim'
  Plug 'tmhedberg/SimpylFold'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'vim-airline/vim-airline'
  Plug 'w0rp/ale'
  Plug 'Yggdroot/indentLine'

  " Deoplete and sources
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'deoplete-plugins/deoplete-jedi' " python
  Plug 'Shougo/neco-vim' " vim
  Plug 'Shougo/neco-syntax' " language syntax
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
call plug#end()
