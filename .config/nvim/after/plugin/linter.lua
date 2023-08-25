local status_ok, linter = pcall(require, "lint")

if not status_ok then
	return
end

linter.linters_by_ft = {
	javascript = { "eslint_d", "cspell" },
	javascriptreact = { "eslint_d", "cspell" },
	typescript = { "eslint_d", "cspell" },
	typescriptreact = { "eslint_d", "cspell" },
	markdown = { "markdownlint", "cspell" },
	json = { "jsonlint" },
	css = { "stylelint" },
	scss = { "stylelint" },
	sass = { "stylelint" },
	less = { "stylelint" },
	html = { "tidy" },
	lua = { "luacheck" },
}

local autocmd = function(event, event_group)
	vim.api.nvim_create_augroup(event_group, { clear = true })
	vim.api.nvim_create_autocmd(event, {
		pattern = "*",
		group = event_group,
		callback = function()
			linter.try_lint()
		end,
	})
end

autocmd("BufWritePost", "LintOnSave")
autocmd("InsertLeave", "LintOnInsertLeave")
autocmd("BufRead", "LintOnBufRead")
