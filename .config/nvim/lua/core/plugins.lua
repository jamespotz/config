local fn = vim.fn
local api = vim.api

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap =
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end
-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local load_config = function(name)
	local module_path = "config/" .. name
	require(module_path)
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

packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Package manager

	-- Startup
	use({ "lewis6991/impatient.nvim", config = load_config("impatient") })
	use("nathom/filetype.nvim")
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = load_config("alpha"),
	})

	-- Colorscheme's
	use("bluz71/vim-nightfly-guicolors")
	use("folke/tokyonight.nvim")
	use("EdenEast/nightfox.nvim")

	-- Debugger
	use({ "mfussenegger/nvim-dap", config = load_config("nvim-dap") })

	-- Neovim lsp Plugins
	use("neovim/nvim-lspconfig")
	use({ "onsails/lspkind-nvim", config = load_config("lspkind") })
	use("tjdevries/nlua.nvim")
	use("nvim-lua/lsp_extensions.nvim")

	-- Neovim LSP Installer
	use({ "williamboman/nvim-lsp-installer", config = load_config("lsp") })

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
		config = load_config("cmp"),
	})
	use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })

	-- TypeScript Utils
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	-- Formatting
	use({ "jose-elias-alvarez/null-ls.nvim", config = load_config("null_ls") })

	-- Editorconfig
	use("editorconfig/editorconfig-vim")

	-- LSP diagnostics and colors
	use({ "folke/trouble.nvim", config = load_config("trouble") })
	use({ "folke/lsp-colors.nvim", config = load_config("lsp_colors") })

	-- Neovim Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = load_config("treesitter"),
		run = ":TSUpdate",
	})
	use("nvim-treesitter/playground")
	use("nvim-treesitter/nvim-treesitter-textobjects")

	-- Neovim Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" }, { "nvim-lua/popup.nvim" } },
		config = load_config("telescope"),
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- LSP Signatures
	use({ "ray-x/lsp_signature.nvim", config = load_config("lsp_signature") })

	-- Auto pairs
	use({ "windwp/nvim-autopairs", config = load_config("autopairs") })

	-- Auto Close/Rename tags
	use("windwp/nvim-ts-autotag")

	-- Colors
	use({
		"norcalli/nvim-colorizer.lua",
		config = load_config("colorizer"),
	})

	-- Indent lines
	use({ "lukas-reineke/indent-blankline.nvim", event = "BufEnter", config = load_config("indent") })

	-- Rainbow brackets
	use("p00f/nvim-ts-rainbow")

	-- Surround text
	-- use("blackcauldron7/surround.nvim")
	use("tpope/vim-surround")

	-- Commenting
	use({ "numToStr/Comment.nvim", config = load_config("comment") })
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Git Signs
	use({
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		requires = { "nvim-lua/plenary.nvim" },
		config = load_config("git"),
	})

	-- Easier motions
	use({ "phaazon/hop.nvim", config = load_config("hop") })

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
		config = load_config("nvim_tree"),
	})

	-- Marks
	use({ "ThePrimeagen/harpoon", config = load_config("harpoon") })

	-- Terminal
	use({ "voldikss/vim-floaterm", config = load_config("floaterm") })

	-- Bufferline
	use({ "akinsho/bufferline.nvim", tag = "v2.*", event = "BufWinEnter", config = load_config("bufferline") })

	-- Statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = load_config("lualine"),
	})

	-- Testing
	use({ "vim-test/vim-test", config = load_config("vim_test") })

	-- Highlight text under cursor
	use("RRethy/vim-illuminate")

	-- Todo commentstring
	use({
		"folke/todo-comments.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = load_config("todo_comments"),
	})

	-- Refactoring
	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = load_config("refactoring"),
	})

	-- Project management
	use({ "ahmedkhalf/project.nvim", config = load_config("project") })

	-- Git Conflicts
	use({ "akinsho/git-conflict.nvim", config = load_config("git-conflict") })

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
		config = load_config("octo_git"),
	})

	use({ "folke/which-key.nvim", event = "BufWinEnter", config = load_config("which-key") })

	use({ "rcarriga/nvim-notify", config = load_config("notify") })

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
		config = load_config("scroll"),
	})

	if PACKER_BOOTSTRAP then
		packer.sync()
		print("Plugins synced...")
	end
end)
