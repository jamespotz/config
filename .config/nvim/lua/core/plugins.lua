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
	})
	use({
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	})

	-- Colorscheme's
	use("EdenEast/nightfox.nvim")
	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})

	-- Debugger
	use({
		"mfussenegger/nvim-dap",
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
	})
	use("tjdevries/nlua.nvim")
	use("nvim-lua/lsp_extensions.nvim")
	use({
		"SmiteshP/nvim-navic",
	})

	-- Neovim LSP Installer
	use({
		"williamboman/mason.nvim",
		requires = { "williamboman/mason-lspconfig.nvim" },
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
	})

	-- Neovim Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",

		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	use("nvim-treesitter/playground")
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use({
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup()
		end,
	})
	use({
		"folke/paint.nvim",
		config = function()
			require("paint").setup({
				---@type PaintHighlight[]
				highlights = {
					{
						-- filter can be a table of buffer options that should match,
						-- or a function called with buf as param that should return true.
						-- The example below will paint @something in comments with Constant
						filter = { filetype = { "lua", "javascript" } },
						pattern = "%s*%-%-%-%s*(@%w+)",
						hl = "Constant",
					},
				},
			})
		end,
	})

	-- Formatting
	use({
		"jose-elias-alvarez/null-ls.nvim",
	})
	use("jayp0521/mason-null-ls.nvim")

	-- Editorconfig
	use("editorconfig/editorconfig-vim")

	-- LSP diagnostics and colors
	use({
		"folke/lsp-colors.nvim",
	})

	use({
		"folke/noice.nvim",
		event = "VimEnter",

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
		tag = "0.1.x",
		requires = { { "nvim-lua/plenary.nvim" }, { "nvim-lua/popup.nvim" } },
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- Auto pairs
	use({
		"windwp/nvim-autopairs",
	})

	-- Auto Close/Rename tags
	use("windwp/nvim-ts-autotag")

	-- Colors
	use({
		"norcalli/nvim-colorizer.lua",
	})

	-- Indent lines
	use({
		"lukas-reineke/indent-blankline.nvim",
	})

	-- Rainbow brackets
	use("p00f/nvim-ts-rainbow")

	-- Surround text
	-- use("blackcauldron7/surround.nvim")
	use("tpope/vim-surround")
	--use("tpope/vim-sleuth")

	-- Commenting
	use({
		"numToStr/Comment.nvim",

		event = "BufRead",
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	})
	use({ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPost" })

	-- Git Signs
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		event = "BufRead",
	})

	-- Easier motions
	use({
		"phaazon/hop.nvim",
	})

	-- File Explorer
	use("nvim-tree/nvim-web-devicons") -- for file icons
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})

	-- Marks
	use({
		"ThePrimeagen/harpoon",
	})

	-- Terminal
	use({
		"voldikss/vim-floaterm",
	})

	-- Bufferline
	use({
		"akinsho/bufferline.nvim",

		event = "BufWinEnter",
	})

	-- Statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- Testing
	use({
		"vim-test/vim-test",
	})

	-- Highlight text under cursor
	use("RRethy/vim-illuminate")

	-- Todo commentstring
	use({
		"folke/todo-comments.nvim",
		event = "BufRead",
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- Refactoring
	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})

	-- Git Conflicts
	use({
		"akinsho/git-conflict.nvim",
		tag = "*",
	})

	use({
		"folke/which-key.nvim",

		event = "BufWinEnter",
	})

	use({
		"rcarriga/nvim-notify",
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
	})

	if PACKER_BOOTSTRAP then
		packer.sync()
		print("Plugins synced...")
	end
end)
