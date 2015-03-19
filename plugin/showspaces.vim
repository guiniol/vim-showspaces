" This file hilights spaces at the beginning of lines, even when they are
" mixed with tabs. Only does it if b:showSpaces is set to 1. Uses conceallevel
" so may mess up plugins using it too.

function s:showSpaces()
	if exists("b:showSpaces")
		if b:showSpaces == 1
			set conceallevel=1
			" Rules for files without existing syntax file
			syn match MoreSpacesAtBeginning /\%(^\s*\)\@<= / conceal cchar=·
			" Rules for files with an an existing syntax file
			autocmd Syntax * syn match MoreSpacesAtBeginning /\%(^\s*\)\@<= / conceal cchar=·
			hi! link Conceal ErrorMsg
		endif
	endif
endfunction

autocmd BufEnter * :call s:showSpaces()

