function! s:RubyAutocorrect(current_args)
	let l:cursor_position = getcurpos()
	silent execute  "%!ruby_autocorrect"

	" Reset the cursor position if we moved
	if l:cursor_position != getcurpos()
		call setpos('.', l:cursor_position)
	endif
endfunction

augroup ruby_autocorrect
	autocmd!
        " Use BufWritePre to filter the file before it's written since we're
        " processing current buffer instead of the saved file.
        autocmd FileType ruby autocmd BufWritePre <buffer> RubyAutocorrect
augroup END

command! -nargs=? RubyAutocorrect :call <SID>RubyAutocorrect(<q-args>)
