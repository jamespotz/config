" Enable Syntax highlighting
syntax on

" UTF-8 Encoding
set encoding=utf-8
set fileencoding=utf-8

" leader key , not \
let mapleader=","
let maplocalleader=","

" General settings
set autoread
set autowrite
set complete=.,w,b
set completeopt=menu,menuone,noinsert,noselect
set colorcolumn=81
set cursorline
set matchpairs+=<:> 										" Use % to jump between pairs
set mouse=a
set noerrorbells
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set nospell
set smartcase
set spelllang=en_us
set splitbelow
set splitright
set undodir=/tmp
set undofile
set virtualedit=block
set wildmenu
set wildmode=full
set wildoptions=pum
set lazyredraw
set pumblend=10 												" 10% transparency pmen
set winblend=10 											 	" 10% transparency floating window
set clipboard+=unnamedplus
set smartcase
set nu
set nowrap
silent! set cryptmethod=blowfish2
set synmaxcol=200
set formatoptions=cqj
set scrolloff=3
set iskeyword+=-                      	" treat dash separated words as a word text object"
set fileformats=unix,dos
set foldlevelstart=20
set foldmethod=indent " Simple and fast
set foldtext=""

if strlen(exepath('rg'))
  set grepprg=rg\ --vimgrep
  set grepformat^=%f:%l:%c:%m
endif

" Searching
set hlsearch
set ignorecase
set infercase
set incsearch
set inccommand=nosplit

" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·,space:·

" Enable true color
if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Turn backup off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowritebackup
set noswapfile

" Autoread/Autowrite
augroup AutoRead
	au FocusGained,BufEnter * :checktime
augroup END

" Write to file as superuser
command! W w !sudo tee "%" > /dev/null

" Paste toggle
set pastetoggle=<F3>

" Spell checking
set spelllang=en_us
augroup SpellGroup
	autocmd!
	autocmd InsertEnter * set spell
	autocmd InsertLeave * set nospell
augroup END

" Split separator
set fillchars=vert:\▏,fold:-

" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab

" Highlight trailing white spaces
highlight default ExtraWhitespace ctermbg=darkred guibg=darkred
autocmd ColorScheme * highlight default ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\\\@<![\u3000[:space:]]\+$/

" Keep the cursor on the same column
set nostartofline

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Trim White Spaces
autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.rb :call TrimSpaces()

" MatchParen with differenct color
autocmd ColorScheme * highlight MatchParen guibg=darkred ctermbg=darkred

" Command to close tab to the right
command! -nargs=0 Tabr :.+1,$tabdo :q

" CD to root directory
command! -nargs=0 Root call Root()

" <TAB>: completion.
"inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Pyhton3
let g:python3_host_prog='/usr/bin/python3'

" Give some time for multi-key mappings
set timeoutlen=1500

" Terminal timeout
set ttimeoutlen=10

" Improve scroll performance
augroup syntaxSyncMinLines
    autocmd!
    autocmd Syntax * syntax sync minlines=2000
augroup END

" Grep
command! -nargs=+ Grep execute 'silent grep! <args>' | cwindow

" Terminal title
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
