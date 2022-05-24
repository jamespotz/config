local cmd = vim.cmd
local fn = vim.fn
local lsp = vim.lsp
local keymap = vim.keymap

local on_attach = function(client, bufnr)
	require("utils/lsp-utils").on_attach(client, bufnr)
	require("illuminate").on_attach(client)
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
	return
end

local lsp_installer_status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not lsp_installer_status_ok then
	return
end

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local lsp_servers = {
	"tsserver",
	"cssls",
	"cssmodules_ls",
	"dockerls",
	"html",
	"jsonls",
	"stylelint_lsp",
	"sumneko_lua",
	"yamlls",
	"graphql",
}

-- Snippet support
local capabilities = cmp_nvim_lsp.update_capabilities(lsp.protocol.make_client_capabilities())

-- Language Server Setups
lsp_installer.setup({
	ensure_installed = lsp_servers,
	automatic_installation = true,
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})

for _, lsp in pairs(lsp_servers) do
	if lsp == "tsserver" then
		lspconfig.tsserver.setup({
			on_attach = function(client, bufnr)
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
				vim.notify("Language server loaded", nil, { title = "tsserver" })
			end,
			capabilities = capabilities,
			settings = {
				documentFormatting = false,
			},
		})
	elseif lsp == "jsonls" then
		lspconfig.jsonls.setup({
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				vim.notify("Language server loaded", nil, { title = "jsonls" })
			end,
			capabilities = capabilities,
			settings = {
				documentFormatting = false,
				json = {
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
				},
			},
		})
	elseif lsp == "html" then
		lspconfig[lsp].setup({
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				vim.notify("Language server loaded", nil, { title = lsp })
			end,
			capabilities = capabilities,
			settings = {
				html = {
					format = {
						templating = true,
						wrapLineLength = 120,
						wrapAttributes = "auto",
					},
					hover = {
						documentation = true,
						references = true,
					},
				},
			},
		})
	else
		lspconfig[lsp].setup({
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				vim.notify("Language server loaded", nil, { title = lsp })
			end,
			capabilities = capabilities,
			settings = {
				documentFormatting = false,
			},
		})
	end
end

-- replace the default lsp diagnostic letters with prettier symbols
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- format on :wq
cmd([[cabbrev wq execute "lua vim.lsp.buf.formatting_seq_sync()" <bar> wq]])
