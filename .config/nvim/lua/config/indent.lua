local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end

indent_blankline.setup({
	char = "|",
	-- for example, context is off by default, use this to turn it on
	show_current_context = true,
	show_current_context_start = true,
	show_end_of_line = true,
	show_trailing_blankline_indent = false,
	filetype_exclude = { "help", "packer" },
	buftype_exclude = { "terminal", "nofile" },
})
