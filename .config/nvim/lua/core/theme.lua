-- Colorscheme
local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
	return
end

vim.g.catppuccin_flavour = "macchiato"

local colors = require("catppuccin.palettes").get_palette()
catppuccin.setup({
	term_colors = true,
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		functions = { "bold" },
		operators = { "bold" },
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
		lsp_trouble = true,
		which_key = true,
		hop = true,
		dap = {
			enabled = true,
		},
		ts_rainbow = true,
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
