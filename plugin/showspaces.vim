" This file hilights spaces at the beginning of lines, even when they are
" mixed with tabs. Only does it if b:showSpaces is set to 1. Uses conceallevel
" so may mess up plugins using it too, this can be controlled by
" g:showSpacesConceal.

if !exists("*s:showSpaces")
	function s:showSpaces()
		if get(b:, "showSpaces")
			if get(b:, "showSpacesConceal")
				set conceallevel=1
				if get(b:, "showMixedOnly")
					syn match MoreSpacesAtBeginning / / contained containedin=MoreMixedSpacesAtBeginning conceal cchar=·
					syn match MoreMixedSpacesAtBeginning /\v(^\t* *(\S|$))@!(^\s*\t\s*)@=(^\s* \s*)@=\s+/ contains=MoreSpacesAtBeginning
				else
					syn match MoreSpacesAtBeginning /\v(^\s*)@<= / conceal cchar=·
				endif
				hi def link Conceal ErrorMsg
			else
				if get(b:, "showMixedOnly")
					syn match MoreSpacesAtBeginning / / contained containedin=MoreMixedSpacesAtBeginning
					syn match MoreMixedSpacesAtBeginning /\v(^\t* *(\S|$))@!(^\s*\t\s*)@=(^\s* \s*)@=\s+/ contains=MoreSpacesAtBeginning
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

autocmd BufEnter * :call s:showSpaces()

if !exists("*s:showMixedFile")
	function s:showMixedFile()
		if get(b:, "showMixedFile")
			if get(b:, "showMixedFileConceal")
				set conceallevel=1
				if get(b:, "showMixedOnly")
					syn match MoreMixedSpaces / / contained containedin=MoreMixedBeginning conceal cchar=·
					syn match MoreMixedBeginning /\v^\s+/ contained containedin=MoreMixedFile contains=MoreMixedSpaces
					syn match MoreMixedFile /\v(\_.*\_^\s*\t\s*)@=(\_.*\_^\s* \s*)@=\_.*/ contains=MoreMixedBeginning
				else
					syn match MoreMixedBeginning /\v^\s+/ contained containedin=MoreMixedFile conceal cchar=·
					syn match MoreMixedFile /\v(\_.*\_^\s*\t\s*)@=(\_.*\_^\s* \s*)@=\_.*/ contains=MoreMixedBeginning
				endif
				hi def link Conceal ErrorMsg
			else
				if get(b:, "showMixedOnly")
					syn match MoreMixedSpaces / / contained containedin=MoreMixedBeginning
					syn match MoreMixedBeginning /\v^\s+/ contained containedin=MoreMixedFile contains=MoreMixedSpaces
					syn match MoreMixedFile /\v(\_.*\_^\s*\t\s*)@=(\_.*\_^\s* \s*)@=\_.*/ contains=MoreMixedBeginning
				else
					syn match MoreMixedSpaces /\v^\s+/ contained containedin=MoreMixedFile
					syn match MoreMixedFile /\v(\_.*\_^\s*\t\s*)@=(\_.*\_^\s* \s*)@=\_.*/ contains=MoreMixedSpaces
				endif
				hi def link MoreMixedSpaces ErrorMsg
			endif
		else
			silent! syn clear MoreMixedSpaces
			silent! syn clear MoreMixedBeginning
			silent! syn clear MoreMixedFile
		endif
	endfunction
endif

if !exists("*ToggleShowMixedFile")
	function ToggleShowMixedFile()
		if get(b:, "showMixedFile")
			let b:showMixedFile = 0
		else
			let b:showMixedFile = 1
		endif
		call s:showMixedFile()
	endfunction

	command ToggleShowMixedFile :call ToggleShowMixedFile()
endif

autocmd BufEnter * :call s:showMixedFile()

