local api = vim.api

local highlight_yank = api.nvim_create_augroup("HighlightYank", { clear = true })
api.nvim_create_autocmd({ "TextYankPost" }, {
	group = highlight_yank,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			timeout = 500,
			on_visual = false,
			higroup = "Visual",
		})
	end,
})

local check_outside_time = api.nvim_create_augroup("CheckOutsideTime", { clear = true })
api.nvim_create_autocmd({ "WinEnter", "BufEnter", "FocusGained" }, {
	group = check_outside_time,
	pattern = "*",
	command = "silent! checktime",
})
