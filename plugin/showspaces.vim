" This file hilights spaces at the beginning of lines, even when they are
" mixed with tabs. Only does it if b:showSpaces is set to 1. Uses conceallevel
" so may mess up plugins using it too.


if exists("b:showSpaces")
	let s:showSpaces = b:showSpaces
else
	let s:showSpaces = 0
endif

if s:showSpaces == 1
	set conceallevel=1
	" Rules for files without existing syntax file
	syn match SpacesAtBeginning /^\s\+/
	syn match MoreSpacesAtBeginning /\%(^\s*\)\@<= / contained conceal cchar=· containedin=SpacesAtBeginning
	" Rules for files with an an existing syntax file
	autocmd Syntax * syn match SpacesAtBeginning /^\s\+/
	autocmd Syntax * syn match MoreSpacesAtBeginning /\%(^\s*\)\@<= / contained conceal cchar=· containedin=SpacesAtBeginning
	hi! link Conceal ErrorMsg
endif