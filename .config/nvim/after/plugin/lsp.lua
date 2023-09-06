local cmd = vim.cmd
local fn = vim.fn
local lsp = vim.lsp

local on_attach = function(client, bufnr)
	require("utils/lsp-utils").on_attach(client, bufnr)
	require("virtualtypes").on_attach(client, bufnr)
	local navic = require("nvim-navic")

	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always",
				prefix = " ",
				scope = "cursor",
			}
			vim.diagnostic.open_float(nil, opts)
		end,
	})

	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

  require("utils/lsp-utils").formatting_on_attach(client, bufnr)
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
	return
end

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	return
end

local lsp_installer_status_ok, lsp_installer = pcall(require, "mason-lspconfig")
if not lsp_installer_status_ok then
	return
end

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local lsp_servers = {
	"cssls",
	"cssmodules_ls",
	"dockerls",
	"emmet_ls",
	"graphql",
	"html",
	"jsonls",
	"lua_ls",
	"yamlls",
	"marksman",
	"efm",
}

-- Snippet support
local capabilities = cmp_nvim_lsp.default_capabilities()

local configurations = {
	default = {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			vim.notify("Language server loaded", nil, { title = client.name })
		end,
		settings = {
			documentFormatting = false,
		},
	},
	jsonls = {
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
	},
	html = {
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
	},
}

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- Language Server Setups
lsp_installer.setup({
	ensure_installed = lsp_servers,
	automatic_installation = true,
})

-- EFM setup
local efm_configs = require("utils.efm_configs")
local prettier = efm_configs.prettier
local eslint = efm_configs.eslint
local stylua = efm_configs.stylua
local markdownlint = efm_configs.markdownlint
local luacheck = efm_configs.luacheck

local efm_languages = {
	typescript = { eslint, prettier },
	typescriptreact = { eslint, prettier },
	javascript = { eslint, prettier },
	javascriptreact = { eslint, prettier },
	lua = { stylua, luacheck },
	markdown = { markdownlint, prettier },
	json = { prettier },
	css = { prettier },
	html = { prettier },
}

for _, lsp in pairs(lsp_servers) do
	if lsp == "jsonls" then
		lspconfig.jsonls.setup({
			on_attach = configurations.default.on_attach,
			capabilities = capabilities,
			settings = configurations[lsp].settings,
		})
	elseif lsp == "emmet_ls" then
		lspconfig.emmet_ls.setup({
			filetypes = {
				"css",
				"eruby",
				"html",
				"javascript",
				"javascriptreact",
				"less",
				"sass",
				"scss",
				"svelte",
				"pug",
				"typescriptreact",
				"typescript",
				"vue",
			},
			on_attach = configurations.default.on_attach,
			capabilities = capabilities,
			settings = configurations.default.settings,
		})
	elseif lsp == "html" then
		lspconfig.html.setup({
			on_attach = configurations.default.on_attach,
			capabilities = capabilities,
			settings = configurations[lsp].settings,
		})
	elseif lsp == "efm" then
		lspconfig.efm.setup({
			on_attach = configurations.default.on_attach,
			capabilities = capabilities,
			filetypes = vim.tbl_keys(efm_languages),
			settings = {
				rootMarkers = { ".git/" },
				languages = efm_languages,
			},
			init_options = {
				documentFormatting = true,
				documentRangeFormatting = true,
			},
		})
	else
		lspconfig[lsp].setup({
			on_attach = configurations.default.on_attach,
			capabilities = capabilities,
			settings = configurations.default.settings,
		})
	end
end

-- replace the default lsp diagnostic letters with prettier symbols
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({ virtual_text = false })

lsp.handlers["window/showMessage"] = function(_, result, ctx)
	local client = lsp.get_client_by_id(ctx.client_id)
	local lvl = ({ "ERROR", "WARN", "INFO", "DEBUG" })[result.type]
	vim.notify({ result.message }, lvl, {
		title = "LSP | " .. client.name,
		timeout = 10000,
		keep = function()
			return lvl == "ERROR" or lvl == "WARN"
		end,
	})
end

-- format on :wq
cmd([[cabbrev wq execute "lua vim.lsp.buf.format({ timeout_ms = 2000 })" <bar> wq]])

-- lspkind
require("utils/lspkind").setup()
