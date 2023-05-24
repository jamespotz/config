local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

local catppuccin_highlight = require("catppuccin.groups.integrations.bufferline").get()

bufferline.setup({
	highlights = catppuccin_highlight,
	options = {
		hover = {
			enabled = true,
			delay = 200,
		},
		separator_style = "thin",
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and " " or (e == "warning" and " " or " ")
				s = s .. n .. sym
			end
			return s
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = "📁 File Explorer",
				highlight = "Directory",
				text_align = "left",
				separator = true,
			},
		},
	},
})
