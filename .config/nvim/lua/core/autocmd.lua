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

api.nvim_create_user_command("DiffOrig", function()
	-- Get start buffer
	local start = api.nvim_get_current_buf()

	-- `vnew` - Create empty vertical split window
	-- `set buftype=nofile` - Buffer is not related to a file, will not be written
	-- `0d_` - Remove an extra empty start row
	-- `diffthis` - Set diff mode to a new vertical split
	vim.cmd("vnew | set buftype=nofile | read ++edit # | 0d_ | diffthis")

	-- Get scratch buffer
	local scratch = api.nvim_get_current_buf()

	-- `wincmd p` - Go to the start window
	-- `diffthis` - Set diff mode to a start window
	vim.cmd("wincmd p | diffthis")

	-- Map `q` for both buffers to exit diff view and delete scratch buffer
	for _, buf in ipairs({ scratch, start }) do
		vim.keymap.set("n", "q", function()
			api.nvim_buf_delete(scratch, { force = true })
			vim.keymap.del("n", "q", { buffer = start })
		end, { buffer = buf })
	end
end, {})
