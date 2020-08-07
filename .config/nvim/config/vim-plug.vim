if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"------- PLUGIN START -------------------------------------------------
call plug#begin('~/.local/share/nvim/site/plugged')	
	" GIT Integration
	Plug 'mhinz/vim-signify'
	Plug 'tpope/vim-fugitive', { 'as': 'fugitive.vim' }

  " for change " to ' and others
	Plug 'tpope/vim-surround', { 'as': 'surround.vim' }
	
	" Code completion/ Language server
	Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
	Plug 'ajh17/VimCompletesMe'
  Plug 'natebosch/vim-lsc'
  Plug 'dense-analysis/ale'
  
	Plug 'tpope/vim-commentary'
	Plug 'pantharshit00/vim-prisma'
	Plug 'tpope/vim-dotenv'
	
	" Auto Close {[(
  Plug 'tmsvg/pear-tree'

  " File Explorer
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'kristijanhusak/defx-icons'
  Plug 'kristijanhusak/defx-git'
	
	" Fuzzy searching
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
	
	" Database
	Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'
  
  " Colorizer
	Plug 'norcalli/nvim-colorizer.lua'	

  " Undotree
	Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
  
  " [Do]cumentation [GE]nerator
  Plug 'kkoomen/vim-doge'
  
  " Editorconfig Support
  Plug 'editorconfig/editorconfig-vim'
  
  " Better Comments
  Plug 'jbgutierrez/vim-better-comments'

  " QuickScope
  Plug 'unblevable/quick-scope'

  " Syntax highlighting for most languages
  Plug 'sheerun/vim-polyglot'

  " Python
  Plug 'Vimjas/vim-python-pep8-indent'
  
  " Test
  Plug 'janko/vim-test'

  " Markdown
  Plug 'godlygeek/tabular' | Plug 'tpope/vim-markdown'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

  " UI, themes and icons
  Plug 'cocopon/iceberg.vim'
  Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
	Plug 'morhetz/gruvbox'
  Plug 'joshdick/onedark.vim'
  Plug 'whatyouhide/vim-gotham'
  Plug 'dracula/vim', { 'name': 'dracula' }
	Plug 'arcticicestudio/nord-vim'
  Plug 'drewtempelmeyer/palenight.vim'
	Plug 'mhinz/vim-startify'
	Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'skbolton/embark'
	Plug 'Yggdroot/indentLine'
	Plug 'vim-airline/vim-airline', { 'as': 'vim-airline' }
	Plug 'vim-airline/vim-airline-themes', { 'as': 'vim-airline-themes' }
	Plug 'ryanoasis/vim-devicons', { 'as': 'vim-devicons' }
call plug#end()
"------- PLUGIN END ---------------------------------------------------

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
