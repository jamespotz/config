local status_ok, linter = pcall(require, "lint")

if not status_ok then
	return
end

linter.linters_by_ft = {
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	markdown = { "markdownlint" },
	json = { "jsonlint" },
	css = { "stylelint" },
	scss = { "stylelint" },
	sass = { "stylelint" },
	less = { "stylelint" },
	html = { "tidy" },
	lua = { "luacheck" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		linter.try_lint()
	end,
})
