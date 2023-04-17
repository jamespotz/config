local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

mason_null_ls.setup({
	ensure_installed = { "cspell", "stylua", "prettierd", "eslint_d" },
	automatic_installation = true,
	automatic_setup = true,
	handlers = {},
})

null_ls.setup({
	on_attach = require("utils/lsp-utils").formatting_on_attach,
	sources = {
		require("typescript.extensions.null-ls.code-actions"),
	},
})
