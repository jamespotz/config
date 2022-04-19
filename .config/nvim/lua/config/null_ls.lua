local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

require("lsp-format").setup({})

null_ls.setup({
	sources = {
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.diagnostics.cspell,
	},
	on_attach = require("lsp-format").on_attach,
})
