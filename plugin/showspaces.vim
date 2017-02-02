" This file hilights spaces at the beginning of lines, even when they are
" mixed with tabs. Only does it if b:showSpaces is set to 1. Uses conceallevel
" so may mess up plugins using it too, this can be controlled by
" g:showSpacesConceal.

if !exists('*s:showSpaces')
	function s:showSpaces()
		if exists('w:showSpacesId')
			call matchdelete(w:showSpacesId)
			unlet w:showSpacesId
			return
		endif
		if &expandtab
			let w:showSpacesId = matchadd(b:showSpacesHi, '\v%(^\s*)@<=\t', -1)
		else
			if get(b:, 'showSpacesConceal')
				set conceallevel=1
				if get(b:, 'showMixedOnly')
					let w:showSpacesId = matchadd('Conceal', '\v%(^\t@!\s*)@<= |%(^\s*)@<= %(\s*\t\s*)@=', -1, -1, {'conceal': '·'})
				else
					let w:showSpacesId = matchadd('Conceal', '\v%(^\s*)@<= ', -1, -1, {'conceal': '·'})
				endif
				execute "hi def link Conceal ".b:showSpacesHi
			else
				if get(b:, 'showMixedOnly')
					let w:showSpacesId = matchadd(b:showSpacesHi, '\v%(^\t@!\s*)@<= |%(^\s*)@<= %(\s*\t\s*)@=', -1)
				else
					let w:showSpacesId = matchadd(b:showSpacesHi, '\v%(^\s*)@<= ', -1)
				endif
			endif
		endif
	endfunction
endif

if !exists('*ToggleShowSpaces')
	command ToggleShowSpaces :call s:showSpaces()
endif

if !exists('b:showMixedOnly')
	let b:showMixedOnly = 1
endif

if !exists('b:showSpacesHi')
	let b:showSpacesHi = 'ErrorMsg'
endif

autocmd BufEnter * :call s:showSpaces()

