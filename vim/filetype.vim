augroup filetypedetect_local
    autocmd BufNewFile,BufRead,BufWritePost */ansible/*.yaml,*/ansible/*.yml set filetype=yaml.ansible
augroup END

augroup filetype_settings_local
  autocmd FileType fish,lua,python,rust set sw=4
  autocmd FileType go,just,make,sh set sw=0 ts=4 noexpandtab
augroup END
