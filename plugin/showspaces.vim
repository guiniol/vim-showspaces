" This file hilights spaces at the beginning of lines, even when they are
" mixed with tabs. Only does it if b:showSpaces is set to 1. Uses conceallevel
" so may mess up plugins using it too, this can be controlled by
" g:showSpacesConceal.

if !exists("*s:showSpaces")
	function s:showSpaces()
		if &expandtab
			silent! syn clear MoreSpacesAtBeginning
			silent! syn clear MoreMixedSpacesAtBeginning
			return
		endif
		if get(b:, "showSpaces")
			if get(b:, "showSpacesConceal")
				set conceallevel=1
				if get(b:, "showMixedOnly")
					syn match MoreSpacesAtBeginning /\v%(^\t@!\s*)@<= |%(^\s*)@<= %(\s*\t)@=/ conceal cchar=·
				else
					syn match MoreSpacesAtBeginning /\v(^\s*)@<= / conceal cchar=·
				endif
				hi def link Conceal ErrorMsg
			else
				if get(b:, "showMixedOnly")
					syn match MoreSpacesAtBeginning /\v%(^\t@!\s*)@<= |%(^\s*)@<= %(\s*\t)@=/
				else
					syn match MoreSpacesAtBeginning /\v(^\s*)@<= /
				endif
				hi def link MoreSpacesAtBeginning ErrorMsg
			endif
		else
			silent! syn clear MoreSpacesAtBeginning
			silent! syn clear MoreMixedSpacesAtBeginning
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

if !exists("b:showMixedOnly")
	let b:showMixedOnly = 1
endif

autocmd BufEnter * :call s:showSpaces()

