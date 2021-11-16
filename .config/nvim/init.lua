-- Local variables
local fn = vim.fn;
local api = vim.api
local g = vim.g
local opt = vim.opt
local cmd = vim.cmd

-- Install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  -- Neovim lsp Plugins
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim'
  use 'tjdevries/nlua.nvim'
  use 'tjdevries/lsp_extensions.nvim'

  -- Neovim LSP Installer
  use 'williamboman/nvim-lsp-installer'

  -- Neovim LSP Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-emoji'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- Tabnine
  use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}

  -- LSP diagnostics and colors
  use 'folke/trouble.nvim'
  use 'folke/lsp-colors.nvim'

  -- Neovim Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'nvim-treesitter/playground'
  use 'nvim-lua/popup.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- LSP Signatures
  use 'ray-x/lsp_signature.nvim'

  -- LSP lightbulb
  use 'kosayoda/nvim-lightbulb'

  -- Auto pairs
  use 'windwp/nvim-autopairs'

  -- Auto Close/Rename tags
  use 'windwp/nvim-ts-autotag'

  -- Colors
  use 'norcalli/nvim-colorizer.lua'

  -- Indent lines
  use 'lukas-reineke/indent-blankline.nvim'

  -- Rainbow brackets
  use 'p00f/nvim-ts-rainbow'

  -- GitBlame
  use 'tveskag/nvim-blame-line'

  -- Surround text
  use 'blackcauldron7/surround.nvim'

  -- Commenting
  use 'tpope/vim-commentary'

  -- Git Signs
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- Easier motions
  use 'phaazon/hop.nvim'

  use 'mbbill/undotree'
  use 'dbeniamine/cheat.sh-vim'

  -- File Explorer
  use 'kyazdani42/nvim-web-devicons' -- for file icons
  use 'kyazdani42/nvim-tree.lua'

  -- Terminal
  use 'voldikss/vim-floaterm'

  -- Formatting
  use 'mhartington/formatter.nvim'

  -- Colorscheme's
  use 'bluz71/vim-nightfly-guicolors'
  use 'olimorris/onedarkpro.nvim'

  -- Bufferline
  use 'akinsho/nvim-bufferline.lua'

  -- Statusline
  use {
  'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- Testing
  use 'vim-test/vim-test'

  -- Highlight text under cursor
  use 'RRethy/vim-illuminate'

  -- Todo commentstring
  use {
    "folke/todo-comments.nvim",
    requires = { "nvim-lua/plenary.nvim" }
  }

  -- Refactoring
  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-treesitter/nvim-treesitter"}
    }
  }
end)

-- Creates undo directory
local undo_dir = fn.expand('~/.undo')
if fn.isdirectory(undo_dir) == 0 then
  fn.mkdir(undo_dir, 'p');
end

local load_defaults = function()
  local default_options = {
    backspace = { "indent", "eol", "start" },
    backup = false, -- creates a backup file
    clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    cmdheight = 2, -- more space in the neovim command line for displaying messages
    colorcolumn = "80",
    conceallevel = 0, -- so that `` is visible in markdown files
    fileencoding = "utf-8", -- the encoding written to a file
    foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
    foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
    hidden = true, -- required to keep multiple buffers and open multiple buffers
    hlsearch = true, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    mouse = "a", -- allow the mouse to be used in neovim
    pumheight = 10, -- pop up menu height
    pumblend = 20, -- pop up menu transparency
    winblend = 20, -- floating window transparency
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2, -- always show tabs
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    termguicolors = true, -- set term gui colors (most terminals support this)
    title = true, -- set the title of window to the value of the titlestring
    undodir = undo_dir, -- set the undo directory to be saved
    undofile = true, -- enable persistent undo
    updatetime = 250, -- faster completion
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true, -- convert tabs to spaces
    shiftwidth = 2, -- the number of spaces inserted for each indentation
    tabstop = 2, -- insert 2 spaces for a tab
    cursorline = true, -- highlight the current line
    number = true, -- set numbered lines
    relativenumber = false, -- set relative numbered lines
    numberwidth = 4, -- set number column width to 2 {default 4}
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    wrap = false, -- display lines as one long line
    spell = false,
    spelllang = "en",
    scrolloff = 8,
    sidescrolloff = 8,
    wildmenu = true,
    wildmode = 'full',
    wildcharm = fn.char2nr('^I'), -- tab completion for the wildmenu
    lazyredraw = true, -- Only redraw when necessary
    inccommand = 'nosplit', -- Show incremental live substitution
  }

  ---  SETTINGS  ---

  opt.shortmess:append "c"

  for k, v in pairs(default_options) do
    opt[k] = v
  end
end

load_defaults();
cmd [[colorscheme nightfly]]

-- Highlight on yank
api.nvim_exec(
  [[
    augroup YankHighlight
      autocmd!
      autocmd TextYankPost * silent! lua vim.highlight.on_yank()
    augroup end
  ]],
  false
)

-- Autoread
api.nvim_exec([[
  autocmd FocusGained,BufEnter * :checktime
]], false)

--Map blankline
g.indent_blankline_char = '┊'
g.indent_blankline_filetype_exclude = { 'help', 'packer' }
g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
g.indent_blankline_char_highlight = 'LineNr'
g.indent_blankline_show_trailing_blankline_indent = false

-- Keymaps
require('mappings')

-- Settings
require('settings')

-- Test config 
require('test_config')
