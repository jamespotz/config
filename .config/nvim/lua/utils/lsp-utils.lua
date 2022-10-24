local M = {}
local keymap = vim.keymap
local api = vim.api
local util = require("vim.lsp.util")

function M.on_attach(client, bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

local function make_formatting_request(client, bufnr)
	local params = util.make_formatting_params({})
	client.request("textDocument/formatting", params, nil, bufnr)
end

local function make_formatting_request_sync(client, bufnr)
	local params = util.make_formatting_params({})
	local timeout_ms = 1000
	local result, err = client.request_sync("textDocument/formatting", params, timeout_ms, bufnr)
	if result and result.result then
		util.apply_text_edits(result.result, bufnr, client.offset_encoding)
	end
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = api.nvim_create_augroup("LspFormatting", {})

function M.formatting_on_attach(client, bufnr)
	api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	api.nvim_create_autocmd("BufWritePre", {
		group = augroup,
		buffer = bufnr,
		callback = function()
			make_formatting_request_sync(client, bufnr)
		end,
	})

	keymap.set("n", "<leader>f", function()
		make_formatting_request(client, bufnr)
	end, { buffer = bufnr })
end

return M
