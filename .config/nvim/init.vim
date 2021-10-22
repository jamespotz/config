call plug#begin('~/.local/share/nvim/site/plugged')
  " Neovim lsp Plugins
  Plug 'neovim/nvim-lspconfig'
  Plug 'glepnir/lspsaga.nvim'
  Plug 'onsails/lspkind-nvim'
  Plug 'tjdevries/nlua.nvim'
  Plug 'tjdevries/lsp_extensions.nvim'

  " Neovim LSP Installer
  Plug 'williamboman/nvim-lsp-installer'

  " Neovim LSP Completion
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

  " Snippets
  Plug 'rafamadriz/friendly-snippets'

  " LSP diagnostics and colors
  Plug 'folke/trouble.nvim'
  Plug 'folke/lsp-colors.nvim'

  " Neovim Tree shitter
  Plug 'nvim-treesitter/nvim-treesitter', { 'branch': '0.5-compat', 'do': ':TSUpdate' }
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  Plug 'nvim-treesitter/playground'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'

  " LSP Signatures
  Plug 'ray-x/lsp_signature.nvim'

  " Auto pairs
  Plug 'windwp/nvim-autopairs'

  " Auto Close/Rename tags
  Plug 'windwp/nvim-ts-autotag'

  " Colors
  Plug 'norcalli/nvim-colorizer.lua'

  " Indent lines
  Plug 'lukas-reineke/indent-blankline.nvim'

  " Rainbow brackets
  Plug 'p00f/nvim-ts-rainbow'

  " GitBlame
  Plug 'tveskag/nvim-blame-line'

  " Surround text
  Plug 'blackcauldron7/surround.nvim'

  " Commenting
  Plug 'tpope/vim-commentary'

  " Git Signs
  Plug 'lewis6991/gitsigns.nvim'

  Plug 'mbbill/undotree'
  Plug 'dbeniamine/cheat.sh-vim'

  " File Explorer
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'

  " Terminal
  Plug 'voldikss/vim-floaterm'

  " Formatting
  Plug 'mhartington/formatter.nvim'

  Plug 'bluz71/vim-nightfly-guicolors'
  Plug 'olimorris/onedarkpro.nvim'
  Plug 'akinsho/nvim-bufferline.lua'
call plug#end()

let mapleader = " "
set autoread
set exrc " Wont open project .nvimrc without this here
set fileencoding="utf-8"
set splitbelow
set pastetoggle=<F3>
set virtualedit+=onemore
set mouse=a
set guicursor=
set relativenumber
set hidden
set noerrorbells
set number
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set signcolumn=yes
set clipboard+=unnamedplus
set timeoutlen=100

" Give more space displaying messages
set cmdheight=1

" Lower for better user experience
set updatetime=300

" Dont pass message to |ins-completion-menu|
set shortmess+=c

set colorcolumn=80

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Realtime substitution
set inccommand=split

" Treat dash as a word text object
set iskeyword+=-

" highlight current line
set cursorline

" Font
set guifont=JetBrains\ Mono\ Medium\ Nerd\ Font\ Complete:h14

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

colorscheme nightfly

let loaded_matchparen = 1

fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup ThePoltergeist
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Default to static completion for SQL
let g:omni_sql_default_compl_type = 'syntax'

" Autread
au FocusGained,BufEnter * :checktime

lua require('settings')

" blankline

let g:indentLine_enabled = 1
let g:indent_blankline_char = "▏"

let g:indent_blankline_filetype_exclude = [ "help", "terminal", "dashboard" ]
let g:indent_blankline_buftype_exclude = [ "terminal" ]

let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:indent_blankline_show_first_indent_level = v:false
