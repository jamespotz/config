return {
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Colorscheme's
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
	},
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000 },

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
	"nvim-lua/lsp_extensions.nvim",
	"SmiteshP/nvim-navic",

	-- Neovim LSP Installer
	{
		"williamboman/mason.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		build = ":MasonUpdate",
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
			{ "lukas-reineke/cmp-under-comparator" },
		},
	},

	-- Neovim Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
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
	{
		"Wansmer/treesj",
		keys = { "<space>m", "<space>j", "<space><space>s" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({})
		end,
	},

	-- Typescript
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
		config = function()
			require("typescript-tools").setup({
				settings = {
					tsserver_plugins = {
						-- for TypeScript v4.9+
						"@styled/typescript-styled-plugin",
						-- or for older TypeScript versions
						-- "typescript-styled-plugin",
					},
				},
			})
		end,
	},

	-- Linter
	{ "mfussenegger/nvim-lint" },
	-- Formatter
	{ "mhartington/formatter.nvim" },

	-- UI
	{
		"folke/noice.nvim",
		event = "VimEnter",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
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
	"uga-rosa/ccc.nvim",

	-- Indent lines
	"lukas-reineke/indent-blankline.nvim",

	-- Mini surround
	{
		"echasnovski/mini.surround",
		version = false,
		config = function()
			require("mini.surround").setup()
		end,
	},
	-- Mini bufremove
	{
		"echasnovski/mini.bufremove",
		version = false,
		config = function()
			require("mini.bufremove").setup()
			vim.keymap.set("n", "Q", "<cmd>lua MiniBufremove.delete()<cr>", { silent = true, noremap = true })
		end,
	},

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
	{
		"ggandor/leap.nvim",
		dependencies = { "tpope/vim-repeat" },
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	-- File Explorer
	"nvim-tree/nvim-web-devicons", -- for file icons
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
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

	"karb94/neoscroll.nvim",
	{
		"AckslD/muren.nvim",
		config = function()
			require("muren").setup()
			vim.keymap.set("n", "<M-f>", require("muren.api").toggle_ui, { noremap = true, silent = true })
		end,
	},
	{ "jubnzv/virtual-types.nvim" },
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		config = function()
			require("barbecue").setup({
				theme = "tokyonight",
			})
		end,
	},
	-- { "Bekaboo/dropbar.nvim" },
}
