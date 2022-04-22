local cmd = vim.cmd
local fn = vim.fn
local lsp = vim.lsp
local keymap = vim.keymap

require("lsp-format").setup({
	typescript = {
		exclude = { "tsserver", "stylelint_lsp" },
	},
	javascript = {
		exclude = { "tsserver", "stylelint_lsp" },
	},
	typescriptreact = {
		exclude = { "tsserver", "stylelint_lsp" },
	},
	javascriptreact = {
		exclude = { "tsserver", "stylelint_lsp" },
	},
})

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr }
	require("lsp-format").on_attach(client)

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

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
		vim.notify("Language server loaded", nil, { title = server.name })
	end

	opts.capabilities = capabilities
	opts.flags = {
		debounce_text_changes = 150,
	}

	if server.name == "jsonls" then
		opts.on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			vim.notify("Language server loaded", nil, { title = server.name })
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
		opts.settings = {
			stylelintplus = {
				autoFixOnSave = true,
				autoFixOnFormat = true,
				cssInJs = true,
			},
		}

		opts.on_attach = function(client, bufnr)
			on_attach(client, bufnr)

			vim.notify("Language server loaded", nil, { title = server.name })
		end
	end

	if server.name == "sqlls" then
		opts.cmd = { "sql-language-server", "up", "--method", "stdio" }
	end

	if server.name == "cssmodules_ls" then
		opts.on_attach = function(client, bufnr)
			client.server_capabilities.goto_definition = false
			on_attach(client, bufnr)

			vim.notify("Language server loaded", nil, { title = server.name })
		end
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
			on_attach(client, bufnr)

			local ts_utils = require("nvim-lsp-ts-utils")
			ts_utils.setup({
				enable_import_on_completion = true,
				import_all_timeout = 5000, -- ms
				update_imports_on_move = true,
			})

			-- required to fix code action ranges and filter diagnostics
			ts_utils.setup_client(client)

			local options = { buffer = bufnr, silent = true }
			keymap.set("n", "<leader>oi", ":TSLspOrganize<CR>", options)
			keymap.set("n", "<leader>R", ":TSLspRenameFile<CR>", options)
			keymap.set("n", "<leader>ia", ":TSLspImportAll<CR>", options)

			vim.notify("Language server loaded", nil, { title = server.name })
		end
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

-- format on :wq
cmd([[cabbrev wq execute "Format sync" <bar> wq]])
