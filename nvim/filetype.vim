augroup filetypedetect_local
	autocmd BufNewFile,BufRead,BufWritePost */ansible/*.yaml,*/ansible/*.yml set filetype=yaml.ansible
	autocmd BufNewFile,BufRead,BufWritePost */zsh/*,_zsh* set filetype=zsh
augroup END
