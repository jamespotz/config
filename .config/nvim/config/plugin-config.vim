" Airline/powerline
let g:airline_powerline_fonts = 1
let airline#extensions#coc#error_symbol = 'E:'
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
let airline#extensions#coc#warning_symbol = 'W:'

" Extensions
let g:airline_extensions = [
\	'branch',
\	'coc',
\	'fugitiveline',
\	'hunks',
\	'quickfix',
\	'tabline',
\	'term',
\	'whitespace',
\	'wordcount'
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
let g:airline_theme='gotham'


" vim-devicons
let g:webdevicons_enable = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_flagship_statusline = 1
let g:WebDevIconsUnicodeDecorateFileNodes = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderPatternMatching = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1
let WebDevIconsUnicodeDecorateFolderNodesExactMatches = 1

" Indent line
let g:indentLine_enabled = 1
let g:indentLine_fileTypeExclude = ['coc-explorer', 'fzf', 'floaterm', 'startify']
let g:indentLine_char = ''
autocmd! User indentLine doautocmd indentLine Syntax
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#616161'

" FUGITIVE
nnoremap <space>gw :Gwrite<CR>
nnoremap <space>gc :Gcommit<CR>
nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gb :Git branch<Space>
nnoremap <space>go :Git checkout<Space>

" COC Config
let g:coc_global_extensions = [
		\ 'coc-snippets',
		\ 'coc-tsserver',
		\ 'coc-eslint',
		\ 'coc-prettier',
		\ 'coc-json',
		\ 'coc-solargraph',
		\ 'coc-css',
		\ 'coc-html',
		\ 'coc-vetur',
		\ 'coc-explorer',
		\ 'coc-yank',
		\ 'coc-emmet',
		\	'coc-db',
		\ 'coc-stylelintplus',
		\ 'coc-python',
		\ 'coc-marketplace',
		\ 'coc-utils',
    \ 'coc-rls',
    \ 'coc-emoji',
    \ 'coc-pairs',
    \ 'coc-git',
		\ ]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ kite#completion#autocomplete()
      "\ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<CR>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<CR>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<CR>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<CR>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<CR>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Prettier autoformat
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Eslint autoFix
command! -nargs=0 EsFix :CocCommand eslint.executeAutofix

" Coc Explorer
nnoremap <C-b> :CocCommand explorer<CR>

" Coc Yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<CR>

" multiple cursors
nmap <silent> <C-c> <Plug>(coc-cursors-position)
nmap <expr> <silent> <A-d> <SID>select_current_word()
xmap <silent> <A-d> <Plug>(coc-cursors-range)
" use normal command like `<leader>xi(`
nmap <leader>x  <Plug>(coc-cursors-operator)

function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

" FZF
let $FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs -g "!{node_modules,.git}"'
"Let the input go up and the search list go down
let $FZF_DEFAULT_OPTS = '--layout=reverse'

" Open FZF and choose floating window
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

" Ctrl+P for fzf file search
nnoremap <C-p> :Files<CR>
nnoremap <C-g> :Rg<CR>

" NEOVIDE Config
let g:neovide_cursor_animation_length = 0.08
let g:neovide_refresh_rate = 60

" Databases
nnoremap <leader>db :DBUI<CR>

" vuejs
" vim vue
let g:vue_disable_pre_processors=1
" vim vue plugin
let g:vim_vue_plugin_load_full_syntax = 1

" Gruvbox config
let g:gruvbox_contrast_dark = 'hard'

" Ensure editorconfig works well with fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Startify config
let g:startify_change_to_vcs_root = 1

" Sneak config
let g:sneak#label = 1

" case insensitive sneak
let g:sneak#use_ic_scs = 1

" imediately move tot the next instance of search, if you move the cursor sneak is back to default behavior
let g:sneak#s_next = 1

" remap so I can use , and ; with f and t
map gS <Plug>Sneak_,
map gs <Plug>Sneak_;

" QuickScope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

" Polyglot config
let g:polyglot_disabled = ['javascript', 'jsx']

" Testing Config
let test#strategy = "neovim"
noremap <silent> <space>tn :TestNearest<CR>
noremap <silent> <space>tf :TestFile<CR>
noremap <silent> <space>ts :TestSuite<CR>
noremap <silent> <space>tl :TestLast<CR>
noremap <silent> <space>tv :TestVisit<CR>
