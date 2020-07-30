" download vim-plug if missing
if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
  silent! execute 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * silent! PlugInstall
endif

"------- PLUGIN START -------------------------------------------------
call plug#begin()  
	" Snippets, syntax and more
	Plug 'honza/vim-snippets'
	
	" GIT Integration
	Plug 'mhinz/vim-signify'
	Plug 'tpope/vim-fugitive', { 'as': 'fugitive.vim' }

  " for change " to ' and others
	Plug 'tpope/vim-surround', { 'as': 'surround.vim' }
	
	" Code completion/ Language server
	Plug 'neoclide/coc.nvim', {'branch': 'release'}


	Plug 'tpope/vim-commentary'
	Plug 'pantharshit00/vim-prisma'
	Plug 'tpope/vim-dotenv'
	
	
	" Fuzzy searching
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
	
	" Database
	Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'

  " Javascript
  Plug 'yuezk/vim-js'
  Plug 'maxmellon/vim-jsx-pretty'
  
  " vuejs
	Plug 'posva/vim-vue'
	Plug 'leafOfTree/vim-vue-plugin'
	
	" CSS3
	Plug 'hail2u/vim-css3-syntax'
	
	" HTML
	Plug 'mattn/emmet-vim'
  
  " Colorizer
	Plug 'norcalli/nvim-colorizer.lua'	

  " Undotree
	Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
  let g:undotree_WindowLayout = 2
  nnoremap U :UndotreeToggle<CR>
  
  " [Do]cumentation [GE]nerator
  Plug 'kkoomen/vim-doge'
  
  " Editorconfig Support
  Plug 'editorconfig/editorconfig-vim'
  
  " Better Comments
  Plug 'jbgutierrez/vim-better-comments'

  " QuickScope
  Plug 'unblevable/quick-scope'

  " Vim Sneak 
  Plug 'justinmk/vim-sneak'

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
