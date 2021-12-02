if empty(glob(stdpath('config') . '/autoload/plug.vim'))
  silent !curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup vimplug_install
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

runtime plugin/asdf.vim
call plug#begin()
  Plug 'andrewferrier/vim-wrapping-softhard'
  Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh', }
  Plug 'benjamineskola/vim-applescript'
  Plug 'christoomey/vim-sort-motion' | Plug 'kana/vim-textobj-indent'
  Plug 'davidhalter/jedi-vim'
  Plug 'ervandew/supertab'
  Plug 'janko/vim-test'
  Plug 'Konfekt/FastFold'
  Plug 'lewis6991/gitsigns.nvim' | Plug 'nvim-lua/plenary.nvim'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'moll/vim-bbye'
  Plug 'morhetz/gruvbox'
  Plug 'nelstrom/vim-textobj-rubyblock' | Plug 'kana/vim-textobj-user'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope.nvim' | Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
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
call plug#end()
