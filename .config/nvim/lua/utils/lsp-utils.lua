local M = {}
local keymap = vim.keymap
local api = vim.api

function M.on_attach(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local opts = { noremap = true, silent = true, buffer = bufnr }
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	keymap.set("n", "K", vim.lsp.buf.hover, opts)
	keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	keymap.set("n", "gr", vim.lsp.buf.references, opts)
	keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = api.nvim_create_augroup("LspFormatting", {})

function M.formatting_on_attach(client, bufnr)
	local handle_format = function()
		vim.lsp.buf.format({
			bufnr = bufnr,
			filter = function()
				return client.name == "null-ls"
			end,
			timeout_ms = 2000,
		})
	end

	api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	api.nvim_create_autocmd("BufWritePre", {
		group = augroup,
		buffer = bufnr,
		callback = handle_format,
	})

	keymap.set("n", "<leader>f", handle_format, { buffer = bufnr })
end

return M
