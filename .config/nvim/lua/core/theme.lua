-- Colorscheme
local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
	return
end

vim.g.catppuccin_flavour = "frappe"

local colors = require("catppuccin.palettes").get_palette()
catppuccin.setup({
	term_colors = true,
	transparent_background = false,
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		functions = { "bold", "italic" },
		operators = { "bold", "italic" },
	},
	integrations = {
		native_lsp = {
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
		lsp_trouble = true,
		which_key = true,
		hop = true,
		dap = {
			enabled = true,
		},
		ts_rainbow = true,
		navic = {
			enabled = true,
			custom_bg = "NONE",
		},
		noice = true,
		notify = true,
		nvimtree = true,
	},
	custom_highlights = {
		StartLogo1 = { fg = "#ffe808" },
		StartLogo2 = { fg = "#ffce00" },
		StartLogo3 = { fg = "#ff9a00" },
		StartLogo4 = { fg = "#ff5a00" },
		StartLogo5 = { fg = "#ff0000" },
	},
})

vim.cmd([[colorscheme catppuccin]])
