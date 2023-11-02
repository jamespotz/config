local M = {}
local keymap = vim.keymap
local api = vim.api

function M.on_attach(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local opts = { noremap = true, silent = true, buffer = bufnr }

	opts.desc = "Show LSP Declarations"
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

	opts.desc = "Show LSP Definitions"
	keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

	opts.desc = "Show documentation under cursor"
	keymap.set("n", "K", vim.lsp.buf.hover, opts)

	opts.desc = "Show LSP implementations"
	keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

	opts.desc = "LSP signature help"
	keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

	opts.desc = "Show LSP type definitions"
	keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

	opts.desc = "LSP smart rename"
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	opts.desc = "Show LSP References"
	keymap.set("n", "gr", vim.lsp.buf.references, opts)

	opts.desc = "Show LSP code actions"
	keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

	-- Enable inlay hints if the client supports it.
	if buf_client.server_capabilities.inlayHintProvider then
		local inlay_hints_group = vim.api.nvim_create_augroup("InlayHints", { clear = true })

		-- Initial inlay hint display.
		local mode = vim.api.nvim_get_mode().mode
		vim.lsp.inlay_hint(bufnr, mode == "n" or mode == "v")

		vim.api.nvim_create_autocmd("InsertEnter", {
			group = inlay_hints_group,
			buffer = bufnr,
			callback = function()
				vim.lsp.inlay_hint(bufnr, false)
			end,
		})
		vim.api.nvim_create_autocmd("InsertLeave", {
			group = inlay_hints_group,
			buffer = bufnr,
			callback = function()
				vim.lsp.inlay_hint(bufnr, true)
			end,
		})
	end
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = api.nvim_create_augroup("LspFormatting", {})

function M.formatting_on_attach(client, bufnr)
	local handle_format = function()
		vim.lsp.buf.format({
			bufnr = bufnr,
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
