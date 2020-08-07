" FZF
let $FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs -g "!{node_modules,.git}"'
"Let the input go up and the search list go down
let $FZF_DEFAULT_OPTS = '--layout=reverse'

" Open FZF and choose floating window
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

" Ctrl+P for fzf file search
nnoremap <C-p> :Files<CR>
nnoremap <C-g> :Rg<CR>
