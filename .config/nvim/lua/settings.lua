local api = vim.api
local cmd = vim.cmd
local lsp = vim.lsp
local fn = vim.fn

require("completion")
require("lspkind_config")
require("treesitter")
require("telescope_config")
require("colorizer").setup()
require("file_explorer")
require("floaterm_config")
require("refactor")
require("trouble").setup()
require("todo-comments").setup()
require("lsp-colors").setup({
	Error = "#db4b4b",
	Warning = "#e0af68",
	Information = "#0db9d7",
	Hint = "#10B981",
})

require("gitsigns").setup({
	signs = {
		add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = {
			hl = "GitSignsChange",
			text = "▎",
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn",
		},
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	keymaps = {
		-- Default keymap options
		noremap = true,

		["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'" },
		["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'" },

		["n <leader>hs"] = "<cmd>Gitsigns stage_hunk<CR>",
		["v <leader>hs"] = ":Gitsigns stage_hunk<CR>",
		["n <leader>hu"] = "<cmd>Gitsigns undo_stage_hunk<CR>",
		["n <leader>hr"] = "<cmd>Gitsigns reset_hunk<CR>",
		["v <leader>hr"] = ":Gitsigns reset_hunk<CR>",
		["n <leader>hR"] = "<cmd>Gitsigns reset_buffer<CR>",
		["n <leader>hp"] = "<cmd>Gitsigns preview_hunk<CR>",
		["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
		["n <leader>hS"] = "<cmd>Gitsigns stage_buffer<CR>",
		["n <leader>hU"] = "<cmd>Gitsigns reset_buffer_index<CR>",

		-- Text objects
		["o ih"] = ":<C-U>Gitsigns select_hunk<CR>",
		["x ih"] = ":<C-U>Gitsigns select_hunk<CR>",
	},
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},
	current_line_blame_formatter_opts = {
		relative_time = false,
	},
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000,
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	yadm = {
		enable = true,
	},
})

require("surround").setup({ mappings_style = "surround" })

require("lualine").setup({
	options = { theme = "tokyonight" },
})
require("bufferline").setup({
	options = {
		separator_style = "padded-slant",
		diagnostic = "nvim_lsp",
		custom_areas = {
			right = function()
				local result = {}
				local error = lsp.diagnostic.get_count(0, [[Error]])
				local warning = lsp.diagnostic.get_count(0, [[Warning]])
				local info = lsp.diagnostic.get_count(0, [[Information]])
				local hint = lsp.diagnostic.get_count(0, [[Hint]])

				if error ~= 0 then
					result[1] = { text = "  " .. error, guifg = "#EC5241" }
				end

				if warning ~= 0 then
					result[2] = { text = "  " .. warning, guifg = "#EFB839" }
				end

				if hint ~= 0 then
					result[3] = { text = "  " .. hint, guifg = "#A3BA5E" }
				end

				if info ~= 0 then
					result[4] = { text = "  " .. info, guifg = "#7EA9A7" }
				end
				return result
			end,
		},
	},
})

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
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
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
end

-- Snippet support
local capabilities = require("cmp_nvim_lsp").update_capabilities(lsp.protocol.make_client_capabilities())

-- Language Server Setups
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
	local opts = {}

	opts.on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		require("illuminate").on_attach(client)
		print("Language server loaded: ", server.name)
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

			require("illuminate").on_attach(client)
			print("Language server loaded: ", server.name)
		end

		opts.capabilities = capabilities
		opts.settings = { documentFormatting = false }
	end

	-- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
	server:setup(opts)
	cmd([[ do User LspAttachBuffers ]])
end)

local null_ls = require("null-ls")
null_ls.config({
	sources = {
		null_ls.builtins.code_actions.eslint_d, -- eslint or eslint_d
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.formatting.prettier.with({
			disabled_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		}),
		null_ls.builtins.formatting.stylua,
	},
})

require("lspconfig")["null-ls"].setup({
	on_attach = on_attach,
})

-- replace the default lsp diagnostic letters with prettier symbols
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- nvim-lightbulb
cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
