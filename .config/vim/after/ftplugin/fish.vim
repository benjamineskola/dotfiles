function! s:FishAutocorrect(current_args)
	let l:cursor_position = getcurpos()
	silent execute  "%!fish_indent"

	" Reset the cursor position if we moved
	if l:cursor_position != getcurpos()
		call setpos('.', l:cursor_position)
	endif
endfunction

command! -nargs=? FishAutocorrect :call <SID>FishAutocorrect(<q-args>)
autocmd BufWritePre <buffer> FishAutocorrect
