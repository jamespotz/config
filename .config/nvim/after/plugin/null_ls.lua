local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

mason_null_ls.setup({
	ensure_installed = { "stylua", "eslint_d", "prettier" },
	automatic_installation = true,
})

null_ls.setup({
	on_attach = require("utils/lsp-utils").formatting_on_attach,
})
