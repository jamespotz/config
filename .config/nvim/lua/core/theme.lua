-- Colorscheme
local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
	return
end

vim.g.catppuccin_flavour = "frappe"

local colors = require("catppuccin.palettes").get_palette()
catppuccin.setup({
	term_colors = true,
	transparent_background = true,
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		functions = { "bold", "italic" },
		operators = { "bold", "italic" },
	},
	integrations = {
		native_lsp = {
			virtual_text = {
				errors = { "bold" },
				hints = { "bold" },
				warnings = { "bold" },
				information = { "bold" },
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
		StartLogo1 = { fg = colors.rosewater },
		StartLogo2 = { fg = colors.rosewater },
		StartLogo3 = { fg = colors.rosewater },
		StartLogo4 = { fg = colors.rosewater },
		StartLogo5 = { fg = colors.rosewater },
	},
})

vim.cmd([[colorscheme catppuccin]])
