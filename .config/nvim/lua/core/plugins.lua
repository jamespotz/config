local fn = vim.fn
local api = vim.api

-- Install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
function get_config(name)
	return string.format('require("config/%s")', name)
end

local packer_group = api.nvim_create_augroup("Packer", { clear = true })
api.nvim_create_autocmd("BufWritePost", {
	pattern = "plugins.lua",
	command = "source <afile> | PackerSync",
	group = packer_group,
})

-- initialize and configure packer
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

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

-- Startup
use({ "lewis6991/impatient.nvim", config = get_config("impatient") })
use("nathom/filetype.nvim")
use({
	"goolord/alpha-nvim",
	requires = { "kyazdani42/nvim-web-devicons" },
	config = get_config("alpha"),
})

-- Colorscheme's
use("bluz71/vim-nightfly-guicolors")
use("folke/tokyonight.nvim")
use("EdenEast/nightfox.nvim")

-- Debugger
use({ "mfussenegger/nvim-dap", config = get_config("nvim-dap") })

-- Neovim lsp Plugins
use("neovim/nvim-lspconfig")
use({ "onsails/lspkind-nvim", config = get_config("lspkind") })
use("tjdevries/nlua.nvim")
use("nvim-lua/lsp_extensions.nvim")

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
	},
	config = get_config("cmp"),
})
use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })

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
use({ "ray-x/lsp_signature.nvim", config = get_config("lsp_signature") })

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
use({ "lukas-reineke/indent-blankline.nvim", event = "BufEnter", config = get_config("indent") })

-- Rainbow brackets
use("p00f/nvim-ts-rainbow")

-- Surround text
-- use("blackcauldron7/surround.nvim")
use("tpope/vim-surround")

-- Commenting
use({ "numToStr/Comment.nvim", config = get_config("comment") })
use("JoosepAlviste/nvim-ts-context-commentstring")

-- Git Signs
use({
	"lewis6991/gitsigns.nvim",
	event = "BufRead",
	requires = { "nvim-lua/plenary.nvim" },
	config = get_config("git"),
})

-- Easier motions
use({ "phaazon/hop.nvim", config = get_config("hop") })

-- File Explorer
use("kyazdani42/nvim-web-devicons") -- for file icons
use({
	"kyazdani42/nvim-tree.lua",
	cmd = {
		"NvimTreeOpen",
		"NvimTreeFocus",
		"NvimTreeToggle",
	},
	requires = {
		"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
	},
	config = get_config("nvim_tree"),
})

-- Marks
use({ "ThePrimeagen/harpoon", config = get_config("harpoon") })

-- Terminal
use({ "voldikss/vim-floaterm", config = get_config("floaterm") })

-- Bufferline
use({ "akinsho/bufferline.nvim", tag = "v2.*", event = "BufWinEnter", config = get_config("bufferline") })

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

-- Project management
use({ "ahmedkhalf/project.nvim", config = get_config("project") })

-- Git Conflicts
use({ "akinsho/git-conflict.nvim", config = get_config("git-conflict") })

-- Github
use({
	"pwntester/octo.nvim",
	requires = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"kyazdani42/nvim-web-devicons",
	},
	cmd = {
		"Octo",
	},
	config = function()
		require("octo").setup()
	end,
})

use({ "folke/which-key.nvim", event = "BufWinEnter", config = get_config("which-key") })

use({ "rcarriga/nvim-notify", config = get_config("notify") })

-- Fix CursorHold Bug
-- issue https://github.com/neovim/neovim/issues/12587
use({
	"antoinemadec/FixCursorHold.nvim",
	config = function()
		vim.g.cursorhold_updatetime = 100
	end,
})

use("moll/vim-bbye")

use({
	"karb94/neoscroll.nvim",
	config = function()
		require("neoscroll").setup()
	end,
})

if PACKER_BOOTSTRAP then
	packer.sync()
	print("Plugins synced...")
end
