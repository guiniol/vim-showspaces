" This file hilights spaces at the beginning of lines, even when they are
" mixed with tabs. Only does it if b:showSpaces is set to 1. Uses conceallevel
" so may mess up plugins using it too, this can be controlled by
" g:showSpacesConceal.

if !exists("*s:showSpaces")
	function s:showSpaces()
		if get(b:, "showSpaces")
			if get(b:, "showSpacesConceal")
				set conceallevel=1
				syn match MoreSpacesAtBeginning /\%(^\s*\)\@<= / conceal cchar=·
				hi def link Conceal ErrorMsg
			else
				syn match MoreSpacesAtBeginning /^\t* \s*/
				hi def link MoreSpacesAtBeginning ErrorMsg
			endif
		else
			silent! syn clear MoreSpacesAtBeginning
		endif
	endfunction
endif

if !exists("*ToggleShowSpaces")
	function ToggleShowSpaces()
		if get(b:, "showSpaces")
			let b:showSpaces = 0
		else
			let b:showSpaces = 1
		endif
		call s:showSpaces()
	endfunction

	command ToggleShowSpaces :call ToggleShowSpaces()
endif

autocmd BufEnter * :call s:showSpaces()

