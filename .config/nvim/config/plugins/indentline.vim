" Indent line
let g:indentLine_enabled = 1
let g:indentLine_fileTypeExclude = ['coc-explorer', 'fzf', 'floaterm', 'startify']
let g:indentLine_char = ''
autocmd! User indentLine doautocmd indentLine Syntax
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#616161'
