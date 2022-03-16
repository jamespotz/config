local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local lsp = vim.lsp

local on_attach = function(client, bufnr)
	--Enable completion triggered by <c-x><c-o>
	api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local lsp_signature = require("lsp_signature")
	if lsp_signature then
		lsp_signature.on_attach()
	end

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
	api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "v", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>so",
		[[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
		opts
	)
	cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

	if client.resolved_capabilities.document_highlight then
		cmd([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
	end

	if client.resolved_capabilities.document_formatting then
		cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end

	require("illuminate").on_attach(client)
end

-- Snippet support
local capabilities = require("cmp_nvim_lsp").update_capabilities(lsp.protocol.make_client_capabilities())

-- Language Server Setups
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
	local opts = {}
	opts.settings = { documentFormatting = false }

	opts.on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		print("Language server loaded: ", server.name)
	end

	if server.name == "jsonls" then
		opts.on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
			on_attach(client, bufnr)
			print("Language server loaded: ", server.name)
		end

		opts.settings.json = {
			schemas = {
				{
					fileMatch = { "package.json" },
					url = "https://json.schemastore.org/package.json",
				},
				{
					fileMatch = { "tsconfig.json", "tsconfig.*.json" },
					url = "https://json.schemastore.org/tsconfig.json",
				},
			},
		}
	end

	if server.name == "stylelint_lsp" then
		opts.on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
			on_attach(client, bufnr)
			print("Language server loaded: ", server.name)
		end
	end

	if server.name == "cssls" or server.name == "html" then
		opts.capabilities = capabilities
	end

	if server.name == "sqlls" then
		opts.cmd = { "sql-language-server", "up", "--method", "stdio" }
	end

	-- (optional) Customize the options passed to the server
	if server.name == "tsserver" then
		opts.init_options = {
			preferences = {
				importModuleSpecifierPreference = "relative",
			},
			require("nvim-lsp-ts-utils").init_options,
		}

		opts.on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
			on_attach(client, bufnr)

			local ts_utils = require("nvim-lsp-ts-utils")
			ts_utils.setup({})

			-- required to fix code action ranges and filter diagnostics
			ts_utils.setup_client(client)

			local options = { silent = true }
			api.nvim_buf_set_keymap(bufnr, "n", "<leader>oi", ":TSLspOrganize<CR>", options)
			api.nvim_buf_set_keymap(bufnr, "n", "<leader>R", ":TSLspRenameFile<CR>", options)
			api.nvim_buf_set_keymap(bufnr, "n", "<leader>ia", ":TSLspImportAll<CR>", options)

			print("Language server loaded: ", server.name)
		end

		opts.capabilities = capabilities
	end

	-- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
	server:setup(opts)
	cmd([[ do User LspAttachBuffers ]])
end)

-- replace the default lsp diagnostic letters with prettier symbols
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- nvim-lightbulb
cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])

-- format on :wq
cmd([[cabbrev wq execute "lua vim.lsp.buf.formatting_sync()" <bar> wq]])
