local status_ok, ccc = pcall(require, "ccc")
if not status_ok then
	return
end

ccc.setup({
	highlighter = {
		auto_enable = true,
		lsp = true,
	},
})
