return {
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Colorscheme's
	{ "EdenEast/nightfox.nvim", lazy = false },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
	},

	-- Debugger
	"mfussenegger/nvim-dap",
	{ "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
	{
		"microsoft/vscode-js-debug",
		lazy = true,
		build = "npm install --legacy-peer-deps && npm run compile",
	},

	-- Neovim lsp Plugins
	"neovim/nvim-lspconfig",
	"onsails/lspkind-nvim",
	"tjdevries/nlua.nvim",
	"nvim-lua/lsp_extensions.nvim",
	"SmiteshP/nvim-navic",

	-- Neovim LSP Installer
	{
		"williamboman/mason.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
	},

	-- Neovim LSP Completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	},

	-- Neovim Treesitter
	{
		"nvim-treesitter/nvim-treesitter",

		build = ":TSUpdate",
	},
	"nvim-treesitter/playground",
	"nvim-treesitter/nvim-treesitter-textobjects",
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup()
		end,
	},
	{
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
	},

	-- Formatting
	"jose-elias-alvarez/null-ls.nvim",
	"jayp0521/mason-null-ls.nvim",

	-- Editorconfig
	"editorconfig/editorconfig-vim",

	-- LSP diagnostics and colors
	"folke/lsp-colors.nvim",

	{
		"folke/noice.nvim",
		event = "VimEnter",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"hrsh7th/nvim-cmp",
		},
	},

	-- Neovim Telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-lua/popup.nvim" } },
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	-- Auto pairs
	"windwp/nvim-autopairs",

	-- Auto Close/Rename tags
	"windwp/nvim-ts-autotag",

	-- Colors
	"norcalli/nvim-colorizer.lua",

	-- Indent lines
	"lukas-reineke/indent-blankline.nvim",

	-- Rainbow brackets
	"mrjones2014/nvim-ts-rainbow",

	-- Surround text
	-- "blackcauldron7/surround.nvim")
	"tpope/vim-surround",
	"tpope/vim-sleuth",

	-- Commenting
	{
		"numToStr/Comment.nvim",

		event = "BufRead",
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPost" },

	-- Git Signs
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "BufRead",
	},

	-- Easier motions
	"phaazon/hop.nvim",

	-- File Explorer
	"nvim-tree/nvim-web-devicons", -- for file icons
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},

	-- Terminal
	"voldikss/vim-floaterm",

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		after = "catppuccin",
		event = "BufWinEnter",
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	},

	-- Testing
	"vim-test/vim-test",

	-- Highlight text under cursor
	"RRethy/vim-illuminate",

	-- Todo commentstring
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Refactoring
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},

	-- Git Conflicts
	{
		"akinsho/git-conflict.nvim",
		version = "*",
	},

	{
		"folke/which-key.nvim",

		event = "BufWinEnter",
	},
	"rcarriga/nvim-notify",

	-- Fix CursorHold Bug
	-- issue https://github.com/neovim/neovim/issues/12587
	{
		"antoinemadec/FixCursorHold.nvim",
		config = function()
			vim.g.cursorhold_updatetime = 100
		end,
	},

	"moll/vim-bbye",
	"karb94/neoscroll.nvim",
}
