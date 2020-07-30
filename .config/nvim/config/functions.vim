" Creates a floating window with a most recent buffer to be used
function! CreateCenteredFloatingWindow()
    let width = float2nr(&columns * 0.8)
    let height = float2nr(&lines * 0.8) - 1
    let top = float2nr((&lines - height) / 2)
    let left = float2nr((&columns - width) / 2)
    let opts = {
     	\'relative': 'editor', 
     	\ 'row': top, 
     	\ 'col': left, 
     	\ 'width': width,
     	\ 'height': height, 
     	\ 'style': 'minimal'}

    let s:buf = nvim_create_buf(v:false, v:true)		
    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    autocmd BufWipeout <buffer> exe 'bwipeout! '.s:buf
endfunction

augroup TermOpenGroup
	autocmd!
	" When term starts, auto go into insert mode
	autocmd TermOpen * startinsert

	" Turn off line numbers etc
	autocmd TermOpen * setlocal listchars= nonumber norelativenumber
augroup END

function! OnTermExit(job_id, code, event) dict
    if a:code == 0
        bwipeout!
    endif
endfunction

function! ToggleTerm(cmd)
    if empty(bufname(a:cmd))
        call CreateCenteredFloatingWindow()
        call termopen(a:cmd, { 'on_exit': function('OnTermExit') })
    else
        bwipeout!
    endif
endfunction

function! ToggleScratchTerm()
    call ToggleTerm('zsh')
endfunction

function! ToggleLazyGit()
    call ToggleTerm('lazygit')
endfunction

function! ToggleLazyDocker()
    call ToggleTerm('lazydocker')
endfunction

function! ToggleYTop()
    call ToggleTerm('ytop')
endfunction


" Delete trailing white space on save, useful for some filetypes ;)
function! TrimSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

" Javascript Fold
function! JavascriptFold() 
    setlocal foldmethod=syntax
    setlocal nofoldenable
    setlocal foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setlocal foldtext=FoldText()
endfunction

function! Root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echo 'Not in git repo'
  else
    execute 'lcd' root
    echo 'Changed directory to: '.root
  endif
endfunction
