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

mason_null_ls.setup_handlers({
	stylua = function(source_name, methods)
		null_ls.register(null_ls.builtins.formatting.stylua)
	end,
	eslint_d = function(source_name, methods)
		null_ls.register(null_ls.builtins.code_actions.eslint_d)
		null_ls.register(null_ls.builtins.diagnostics.eslint_d)
	end,
	prettier = function(source_name, methods)
		null_ls.register(null_ls.builtins.formatting.prettier)
	end,
})

null_ls.setup({
	on_attach = require("utils/lsp-utils").formatting_on_attach,
})
