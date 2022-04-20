local api = vim.api

local highlight_yank = api.nvim_create_augroup("HighlightYank", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
	group = highlight_yank,
})
