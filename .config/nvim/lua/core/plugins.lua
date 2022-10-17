local fn = vim.fn
local api = vim.api

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP =
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
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
	max_jobs = 10,
	profile = {
		enable = true, -- enable profiling via :PackerCompile profile=true
		threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
	},
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

packer.reset()
return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Package manager

	-- Startup
	use({
		"lewis6991/impatient.nvim",
		config = function()
			require("config.impatient")
		end,
	})
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("config.alpha")
		end,
	})

	-- Colorscheme's
	use("EdenEast/nightfox.nvim")
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("core.theme")
		end,
	})

	-- Debugger
	use({
		"mfussenegger/nvim-dap",
		config = function()
			require("config.nvim-dap")
		end,
	})
	use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
	use({
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npm run compile",
	})

	-- Neovim lsp Plugins
	use("neovim/nvim-lspconfig")
	use({
		"onsails/lspkind-nvim",
		config = function()
			require("config.lspkind")
		end,
	})
	use("tjdevries/nlua.nvim")
	use("nvim-lua/lsp_extensions.nvim")

	-- Neovim LSP Installer
	use({
		"williamboman/mason.nvim",
		requires = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("config.lsp")
		end,
	})

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
		config = function()
			require("config.cmp")
		end,
	})
	use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })

	-- Neovim Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.treesitter")
		end,
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	use("nvim-treesitter/playground")
	use("nvim-treesitter/nvim-treesitter-textobjects")

	-- TypeScript Utils
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	-- Formatting
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("config.null_ls")
		end,
	})

	-- Editorconfig
	use("editorconfig/editorconfig-vim")

	-- LSP diagnostics and colors
	use({
		"folke/lsp-colors.nvim",
		config = function()
			require("config.lsp_colors")
		end,
	})

	use({
		"folke/noice.nvim",
		event = "VimEnter",
		config = function()
			require("noice").setup()
		end,
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"hrsh7th/nvim-cmp",
		},
	})

	-- Neovim Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" }, { "nvim-lua/popup.nvim" } },
		config = function()
			require("config.telescope")
		end,
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- LSP Signatures
	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("config.lsp_signature")
		end,
	})

	-- Auto pairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("config.autopairs")
		end,
	})

	-- Auto Close/Rename tags
	use("windwp/nvim-ts-autotag")

	-- Colors
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("config.colorizer")
		end,
	})

	-- Indent lines
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("config.indent")
		end,
	})

	-- Rainbow brackets
	use("p00f/nvim-ts-rainbow")

	-- Surround text
	-- use("blackcauldron7/surround.nvim")
	use("tpope/vim-surround")

	-- Commenting
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("config.comment")
		end,
		event = "BufRead",
	})
	use({ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPost" })

	-- Git Signs
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		event = "BufRead",
		config = function()
			require("config.git")
		end,
	})

	-- Easier motions
	use({
		"phaazon/hop.nvim",
		config = function()
			require("config.hop")
		end,
	})

	-- File Explorer
	use("kyazdani42/nvim-web-devicons") -- for file icons
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
		},
		config = function()
			require("config.nvim_tree")
		end,
	})

	-- Marks
	use({
		"ThePrimeagen/harpoon",
		config = function()
			require("config.harpoon")
		end,
	})

	-- Terminal
	use({
		"voldikss/vim-floaterm",
		config = function()
			require("config.floaterm")
		end,
	})

	-- Bufferline
	use({
		"akinsho/bufferline.nvim",
		config = function()
			require("config.bufferline")
		end,
		event = "BufWinEnter",
	})

	-- Statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("config.lualine")
		end,
	})

	-- Testing
	use({
		"vim-test/vim-test",
		config = function()
			require("config.vim_test")
		end,
	})

	-- Highlight text under cursor
	use("RRethy/vim-illuminate")

	-- Todo commentstring
	use({
		"folke/todo-comments.nvim",
		event = "BufRead",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.todo_comments")
		end,
	})

	-- Refactoring
	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("config.refactoring")
		end,
	})

	-- Git Conflicts
	use({
		"akinsho/git-conflict.nvim",
		tag = "*",
		config = function()
			require("config.git-conflict")
		end,
	})

	-- Github
	use({
		"pwntester/octo.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("config.octo_git")
		end,
	})

	use({
		"folke/which-key.nvim",
		config = function()
			require("config.which-key")
		end,
		event = "BufWinEnter",
	})

	use({
		"rcarriga/nvim-notify",
		config = function()
			require("config.notify")
		end,
	})

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
			require("config.scroll")
		end,
	})

	use({
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
		end,
	})

	if PACKER_BOOTSTRAP then
		packer.sync()
		print("Plugins synced...")
	end
end)
