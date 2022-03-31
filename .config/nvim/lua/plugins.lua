local fn = vim.fn
local api = vim.api

-- Install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
function get_config(name)
	return string.format('require("config/%s")', name)
end

api.nvim_exec(
	[[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]],
	false
)

-- initialize and configure packer
local packer = require("packer")
packer.init({
	profile = {
		enable = true, -- enable profiling via :PackerCompile profile=true
		threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
	},
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})
local use = packer.use
packer.reset()

use("wbthomason/packer.nvim") -- Package manager

-- Colorscheme's
use("bluz71/vim-nightfly-guicolors")
use("folke/tokyonight.nvim")
use("EdenEast/nightfox.nvim")

-- Startup
use({ "lewis6991/impatient.nvim", config = get_config("impatient") })
use({
	"goolord/alpha-nvim",
	requires = { "kyazdani42/nvim-web-devicons" },
	config = get_config("alpha"),
})

-- Neovim lsp Plugins
use("neovim/nvim-lspconfig")
use({ "onsails/lspkind-nvim", config = get_config("lspkind") })
use("tjdevries/nlua.nvim")
use("tjdevries/lsp_extensions.nvim")

-- Neovim LSP Installer
use({ "williamboman/nvim-lsp-installer", config = get_config("lsp") })

-- Neovim LSP Completion
use({
	"hrsh7th/nvim-cmp",
	requires = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "L3MON4D3/LuaSnip" },
		{ "hrsh7th/cmp-emoji" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "rafamadriz/friendly-snippets" },
		{ "f3fora/cmp-spell" },
		{ "hrsh7th/cmp-calc" },
	},
	config = get_config("cmp"),
})
use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })

-- Spelling
use({ "lewis6991/spellsitter.nvim", config = get_config("spellsitter") })

-- TypeScript Utils
use("jose-elias-alvarez/nvim-lsp-ts-utils")
-- Formatting
use({ "jose-elias-alvarez/null-ls.nvim", config = get_config("null_ls") })

-- Editorconfig
use("editorconfig/editorconfig-vim")

-- LSP diagnostics and colors
use({ "folke/trouble.nvim", config = get_config("trouble") })
use({ "folke/lsp-colors.nvim", config = get_config("lsp_colors") })

-- Neovim Treesitter
use({
	"nvim-treesitter/nvim-treesitter",
	config = get_config("treesitter"),
	run = ":TSUpdate",
})
use("nvim-treesitter/playground")
use("nvim-treesitter/nvim-treesitter-textobjects")

-- Neovim Telescope
use({
	"nvim-telescope/telescope.nvim",
	requires = { { "nvim-lua/plenary.nvim" }, { "nvim-lua/popup.nvim" } },
	config = get_config("telescope"),
})
use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

-- LSP Signatures
use("ray-x/lsp_signature.nvim")

-- LSP lightbulb
use({ "kosayoda/nvim-lightbulb", config = get_config("lightbulb") })

-- Auto pairs
use({ "windwp/nvim-autopairs", config = get_config("autopairs") })

-- Auto Close/Rename tags
use("windwp/nvim-ts-autotag")

-- Colors
use({
	"norcalli/nvim-colorizer.lua",
	config = get_config("colorizer"),
})

-- Indent lines
use({ "lukas-reineke/indent-blankline.nvim", config = get_config("indent") })

-- Rainbow brackets
use("p00f/nvim-ts-rainbow")

-- Surround text
-- use("blackcauldron7/surround.nvim")
use("tpope/vim-surround")

-- Commenting
use({ "numToStr/Comment.nvim", config = get_config("comment") })
use("JoosepAlviste/nvim-ts-context-commentstring")

-- Git Signs
use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" }, config = get_config("git") })

-- Easier motions
use({ "phaazon/hop.nvim", event = "BufReadPre", config = get_config("hop") })

use("mbbill/undotree")
use("dbeniamine/cheat.sh-vim")

-- File Explorer
use("kyazdani42/nvim-web-devicons") -- for file icons
use({ "kyazdani42/nvim-tree.lua", config = get_config("nvim_tree") })

-- Terminal
use({ "voldikss/vim-floaterm", config = get_config("floaterm") })

-- Bufferline
use({ "akinsho/nvim-bufferline.lua", config = get_config("bufferline") })

-- Statusline
use({
	"nvim-lualine/lualine.nvim",
	requires = { "kyazdani42/nvim-web-devicons", opt = true },
	config = get_config("lualine"),
})

-- Testing
use({ "vim-test/vim-test", config = get_config("vim_test") })

-- Highlight text under cursor
use("RRethy/vim-illuminate")

-- Todo commentstring
use({
	"folke/todo-comments.nvim",
	requires = { "nvim-lua/plenary.nvim" },
	config = function()
		require("todo-comments").setup()
	end,
})

-- Refactoring
use({
	"ThePrimeagen/refactoring.nvim",
	requires = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-treesitter/nvim-treesitter" },
	},
	config = get_config("refactoring"),
})

use("airblade/vim-rooter")
