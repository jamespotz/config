-- Colorscheme
local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
	return
end

vim.g.catppuccin_flavour = "macchiato"
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
})

vim.cmd([[colorscheme catppuccin]])
