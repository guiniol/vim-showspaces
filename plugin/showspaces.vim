" This file hilights spaces at the beginning of lines, even when they are
" mixed with tabs. Only does it if b:showSpaces is set to 1. Uses conceallevel
" so may mess up plugins using it too.

function s:showSpaces()
	if exists("b:showSpaces") && b:showSpaces == 1
		set conceallevel=1
		if exists("g:showSpacesNoConceal") && g:showSpacesNoConceal == 1
			syn match MoreSpacesAtBeginning /\%(^\s*\)\@<= /
			hi def link MoreSpacesAtBeginning ErrorMsg
		else
			syn match MoreSpacesAtBeginning /\%(^\s*\)\@<= / conceal cchar=·
			hi def link Conceal ErrorMsg
		endif
	else
		silent! syn clear MoreSpacesAtBeginning
	endif
endfunction

function g:ToggleShowSpaces()
	if exists("b:showSpaces") && b:showSpaces == 1
		let b:showSpaces = 0
	else
		let b:showSpaces = 1
	endif
	call s:showSpaces()
endfunction

autocmd BufEnter * :call s:showSpaces()

