" Do NOT initiate ALE when doing short-lived diffs.
if &diff
    finish
endif

let g:ale_fixers = {
 \  'css':        ['prettier'],
 \  'javascript': ['prettier', 'eslint'],
 \  'javascriptreact': ['prettier', 'eslint'],
 \  'json':       ['prettier'],
 \  'scss':       ['prettier'],
 \  'yml':        ['prettier'],
 \}
let g:ale_linters = {
 \  'css':        ['csslint'],
 \  'javascript': ['prettier', 'eslint'],
 \  'javascriptreact': ['prettier', 'eslint'],
 \  'json':       ['jsonlint'],
 \  'markdown':   ['mdl'],
 \  'scss':       ['sasslint'],
 \  'yaml':       ['yamllint'],
 \}

let g:ale_completion_enabled       = 0
let g:ale_lint_on_text_changed     = 'never'
let g:ale_lint_on_insert_leave     = 0
let g:ale_lint_on_save             = 0
let g:ale_lint_on_enter            = 1
let g:ale_fix_on_save              = 1
let g:ale_sign_error               = ''
let g:ale_sign_info                = ''
let g:ale_sign_warning             = ''
if has("nvim")
    let g:ale_echo_cursor          = 0
    let g:ale_virtualtext_cursor   = 1
    let g:ale_virtualtext_prefix   = ' >> '
endif

" ALE fix and toggle mappings.
nmap <Space>f <Plug>(ale_fix)
nmap <Space>l <Plug>(ale_toggle_buffer)
" Navigate errors and warnings using unimpaired-style mappings.
nmap [w <Plug>(ale_previous)zz
nmap ]w <Plug>(ale_next)zz
nmap [W <Plug>(ale_first)zz
nmap ]W <Plug>(ale_last)zz
" Open location list.
nnoremap <Leader>l :lopen<CR>
