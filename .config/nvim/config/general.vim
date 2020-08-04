" Required:
filetype plugin indent on

" UTF-8 Encoding
set encoding=utf-8
set fileencoding=utf-8

" leader key , not \
let mapleader=","
let maplocalleader=","

" General settings
set autoread
set autowrite
set complete+=kspell
set completeopt=menuone,longest
set colorcolumn=81
set cursorline
set matchpairs+=<:> 										" Use % to jump between pairs
set mouse=a
set noerrorbells
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab smarttab
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
set smartindent
set nu
set nowrap
silent! set cryptmethod=blowfish2
set synmaxcol=200
set formatoptions=tcqrn1
set scrolloff=3
set iskeyword+=-                      	" treat dash separated words as a word text object"
set fileformats=unix,dos

" Searching
set hlsearch
set ignorecase
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

" Toggle Syntax Concealing
command! ConcealToggle call ConcealToggle()
let s:concealed=0
function! ConcealToggle()
	" If syntax is already being concealed,
	if s:concealed
		" Unconceal it.
		set conceallevel=0
	" If syntax is NOT already being conealed,
	else
		" Conceal it.
		set conceallevel=2
	endif
	" Mark concealing as having been reversed.
	let s:concealed = !s:concealed
endfunction

" Split separator
set fillchars=vert:\▏,fold:-

" Font
set guifont=Operator\ Mono\ Lig:h16

" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab

" Highlight trailing white spaces
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$/

" Title bar
set title
set titleold="Terminal"
set titlestring=%F

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
highlight MatchParen guibg=red ctermbg=red

" Command to close tab to the right
command! -nargs=0 Tabr :.+1,$tabdo :q

" CD to root directory
command! -nargs=0 Root call Root()

" Pyhton3
let g:python3_host_prog='/usr/bin/python3'
