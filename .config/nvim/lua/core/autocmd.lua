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

api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = api.nvim_buf_get_mark(0, '"')
		local lcount = api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
