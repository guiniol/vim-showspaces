if !exists('*s:showSpaces')
	function s:showSpaces()
		if exists('w:showSpacesId')
			call matchdelete(w:showSpacesId)
			unlet w:showSpacesId
			return
		endif
		if &expandtab
			let w:showSpacesId = matchadd(g:showSpacesHi, '\v%(^\s*)@<=\t', -1)
		else
			if exists('b:showMixedOnly')
				let l:showMixedOnly = get(b:, 'showMixedOnly')
			else
				let l:showMixedOnly = get(g:, 'showMixedOnly')
			endif
			if get(g:, 'showSpacesConceal')
				set conceallevel=1
				if get(l:, 'showMixedOnly')
					let w:showSpacesId = matchadd('Conceal', '\v%(^\t@!\s*)@<= |%(^\s*)@<= %(\s*\t\s*)@=', -1, -1, {'conceal': '·'})
				else
					let w:showSpacesId = matchadd('Conceal', '\v%(^\s*)@<= ', -1, -1, {'conceal': '·'})
				endif
				execute "hi def link Conceal ".g:showSpacesHi
			else
				if get(l:, 'showMixedOnly')
					let w:showSpacesId = matchadd(g:showSpacesHi, '\v%(^\t@!\s*)@<= |%(^\s*)@<= %(\s*\t\s*)@=', -1)
				else
					let w:showSpacesId = matchadd(g:showSpacesHi, '\v%(^\s*)@<= ', -1)
				endif
			endif
		endif
	endfunction
endif

if !exists('*ToggleShowSpaces')
	command ToggleShowSpaces :call s:showSpaces()
endif

if !exists('g:showMixedOnly')
	let g:showMixedOnly = 1
endif

if !exists('g:showSpacesConceal')
	if &conceallevel == 1
		let g:showSpacesConceal = 1
	else
		let g:showSpacesConceal = 0
	endif
endif

if !exists('g:showSpacesHi')
	let g:showSpacesHi = 'ErrorMsg'
endif

autocmd BufEnter * :call s:showSpaces()

