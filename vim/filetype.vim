augroup filetypedetect_local
  autocmd!
  autocmd BufNewFile,BufRead .Brewfile,_Brewfile,pryrc set filetype=ruby
  autocmd BufNewFile,BufRead .config/git/config set filetype=gitconfig
  autocmd BufNewFile,BufRead _tmux.conf set filetype=tmux
  autocmd BufNewFile,BufRead *.ulss set filetype=ulss
  autocmd BufNewFile,BufRead .mkshrc,_mkshrc set filetype=sh
augroup END
