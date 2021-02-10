set exrc " Wont open project .nvimrc without this here
set pastetoggle=<F3>
set virtualedit+=onemore
set mouse=a
set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set number
set tabstop=2 softtabstop=2
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

" Give more space displaying messages
set cmdheight=1

" Lower for better user experience
set updatetime=50

" Dont pass message to |ins-completion-menu|
set shortmess+=c

set colorcolumn=80

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

call plug#begin('~/.local/share/nvim/site/plugged')
  " Neovim lsp Plugins
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'tjdevries/nlua.nvim'
  Plug 'tjdevries/lsp_extensions.nvim'

 " Neovim Tree shitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  Plug 'mhartington/formatter.nvim'

  Plug 'mbbill/undotree'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'mhinz/vim-signify'
  Plug 'sheerun/vim-polyglot'
  Plug 'dbeniamine/cheat.sh-vim'

  " File Explorer
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'

  Plug 'gruvbox-community/gruvbox'
call plug#end()

colorscheme gruvbox
highlight Normal guibg=none

let loaded_matchparen = 1
let mapleader = " "
inoremap <C-c> <esc>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>b :Vex<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" greatest remap ever
vnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

" move at the very end of line
nnoremap $ $l

lua require('completion')
lua require('format')
nnoremap <silent> <C-f> :Format<CR>

"FIND AND REPLACE
nnoremap R :%s/\<<C-r><C-w>\>//g<Left><Left><C-r><C-w>

fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup ThePoltergeist
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END
