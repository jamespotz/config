local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end

indent_blankline.setup({
	char = "|",
	context_patterns = {
		"def",
		"class",
		"return",
		"function",
		"method",
		"^if",
		"^while",
		"jsx_element",
		"^for",
		"^object",
		"^table",
		"block",
		"arguments",
		"if_statement",
		"else_clause",
		"jsx_element",
		"jsx_self_closing_element",
		"try_statement",
		"catch_clause",
		"import_statement",
		"operation_type",
		"arrow_function",
		"^func",
		"with",
		"try",
		"except",
		"argument_list",
		"object",
		"dictionary",
		"element",
		"table",
		"tuple",
		"do_block",
		"^switch",
	},
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
	show_end_of_line = true,
	show_trailing_blankline_indent = false,
	filetype_exclude = { "help", "packer" },
	buftype_exclude = { "terminal", "nofile" },
	use_treesitter = true,
})

vim.cmd([[highlight IndentBlanklineContextChar guifg=#F8BD96 gui=nocombine]])
