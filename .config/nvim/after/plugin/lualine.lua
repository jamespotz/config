local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
	return function(str)
		local win_width = vim.fn.winwidth(0)
		if hide_width and win_width < hide_width then
			return ""
		elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
			return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
		end
		return str
	end
end

lualine.setup({
	options = {
		theme = "catppuccin",
		component_separators = { left = "│", right = "│" },
		section_separators = { left = "", right = "" },
		globalstatus = true,
	},
	sections = {
		lualine_a = {
			{
				"mode",
				icons_enabled = true,
				icon = "",
				fmt = function(str)
					return str:sub(1, 1)
				end,
			},
		},
		lualine_b = {
			{
				"branch",
				fmt = trunc(200, 20, nil),
			},
			"diff",
		},
		lualine_c = { { "filename", icons_enabled = true, icon = "", path = 2 } },
		lualine_y = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				color_error = "#BF616A",
				color_warn = "#EBCB8B",
				color_info = "#88C0D0",
				color_hint = "#3A4151",
			},
		},
		lualine_z = {
			{ "location", icons_enabled = true, icon = "" },
		},
	},
	extensions = { "nvim-tree" },
})
