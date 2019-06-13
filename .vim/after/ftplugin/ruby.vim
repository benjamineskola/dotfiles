function! s:RubyAutocorrect(current_args)
	let l:cursor_position = getcurpos()
	silent execute  "%!ruby_autocorrect"

	" Reset the cursor position if we moved
	if l:cursor_position != getcurpos()
		call setpos('.', l:cursor_position)
	endif
endfunction

command! -nargs=? RubyAutocorrect :call <SID>RubyAutocorrect(<q-args>)
autocmd BufWritePre <buffer> RubyAutocorrect
