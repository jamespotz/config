" Airline/powerline
let g:airline_powerline_fonts = 1
let airline#extensions#ale#enabled = 1

" Extensions
let g:airline_extensions = [
\	'branch',
\	'fugitiveline',
\	'hunks',
\	'quickfix',
\	'tabline',
\	'term',
\	'whitespace',
\	'wordcount',
\ 'coc'
\]

" Tabline
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#tab_nr_type = 1

" testing custom separators:
" https://awesomeopensource.com/project/ryanoasis/powerline-extra-symbols
let g:airline_left_sep = "\uE0B4"
let g:airline_left_alt_sep = "\uE0B5"
let g:airline_right_sep = "\uE0B6"
let g:airline_right_alt_sep = "\uE0B7"

;"

" set the CN (column number) symbol:
let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])

" Airline Theme
let g:airline_theme='nord'

" Truncate long branch name
let g:airline#extensions#branch#displayed_head_limit = 20
let g:airline#extensions#branch#format = 1

" COC integration
let airline#extensions#coc#error_symbol = 'E:'
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
let airline#extensions#coc#warning_symbol = 'W:'
