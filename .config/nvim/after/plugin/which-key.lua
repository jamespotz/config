local status_ok, whichkey = pcall(require, "which-key")
if not status_ok then
	return
end

whichkey.setup({
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ...
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
		spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
	},
	hidden = { "<silent>", "<cmd>", "<cmd>", "<cr>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
})

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
	mode = "v", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

-- nnoremap <leader>ga :Git fetch --all<CR>
-- nnoremap <leader>grum :Git rebase upstream/master<CR>
-- nnoremap <leader>grom :Git rebase origin/master<CR>
--
-- nmap <leader>gh :diffget //3<CR>
-- nmap <leader>gu :diffget //2<CR>
-- nmap <leader>gs :G<CR>
local mappings = {
	[";"] = { "<cmd>Alpha<cr>", "Dashboard" },
	["b"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
	["w"] = { "<cmd>w!<cr>", "Save" },
	["q"] = { "<cmd>q!<cr>", "Quit" },
	["rsv"] = { "<cmd>ReloadConfig<cr>", "Reload $MYVIMRC" },
	c = {
		c = { "<cmd>CccConvert<cr>", "Convert color" },
		p = { "<cmd>CccPick<cr>", "Color Picker" },
	},
	g = {
		name = "Git",
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		C = {
			"<cmd>GitConflictListQf<cr>",
			"List conflicts",
		},
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Git Diff",
		},
	},
	h = {
		name = "Harpoon",
		h = { "<cmd>Telescope harpoon marks<cr>", "View Marks" },
		m = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Add File" },
		n = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Nav next" },
		p = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Nav prev" },
		t = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Toggle Menu" },
	},
	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
		w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
		f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
		g = {
			name = "Go to",
			d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
			t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },
			i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" },
		},
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.diagnostic.goto_next()<cr>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
		e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
	},
	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},
	r = {
		name = "Refactoring",
		d = {
			name = "Debug",
			n = { "<cmd>lua require('refactoring').debug.cleanup({})<cr>", "Print cleanup" },
			p = { "<cmd>lua require('refactoring').debug.printf({below = false})<cr>", "Print debug" },
		},
		i = { "<cmd>lua require('refactoring').refactor('Inline Variable')<cr>", "Inline Variable" },
	},
	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		s = { "<cmd>Telescope live_grep<cr>", "Search Text" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		T = { "<cmd>TodoTelescope<cr>", "Search All Todo's" },
	},
	t = {
		name = "Test",
		c = { "<cmd>lua require('neotest').run.run(vim.fn.expand(\"%\"))<cr>", "Test Current File" },
		s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" },
		o = { "<cmd>lua require('neotest').output_panel.toggle()<cr>", "Test Output" },
	},
}

local vmappings = {
	d = {
		name = "Debug",
		v = { "<cmd>lua require('refactoring').debug.print_var({})<cr>", "Print variable" },
	},
	e = {
		name = "Refactoring",
		e = { "<cmd>lua require('refactoring').refactor('Extract Function')<cr>", "Extract Function" },
		f = { "<cmd>lua require('refactoring').refactor('Extract Function To File')<cr>", "Extract Function to file" },
		i = { "<cmd>lua require('refactoring').refactor('Inline Variable')<cr>", "Inline Variable" },
		v = { "<cmd>lua require('refactoring').refactor('Extract Variable')<cr>", "Extract variable" },
	},
}

local global_mappings = {
	["<C-n>"] = { "<cmd>NvimTreeToggle<cr>", "Toggle NvimTree" },
	["<C-p>"] = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find Files" },
	["<C-g>"] = { "<cmd>FloatermNew --height=0.9 --width=0.9 --name=lazygit lazygit<cr>", "Open lazygit" },
	["<A-c>"] = { "<cmd>copen<cr>", "Open Quickfix" },
	["<A-x>"] = { "<cmd>cclose<cr>", "Close Quickfix" },
	["<F5>"] = { "<cmd>lua require'dap'.continue()<CR>", "Debugger Continue/start" },
	["<F6>"] = { "<cmd>lua require'dap'.terminate()<CR>", "Close Debugger" },
	["<F7>"] = { "<cmd>FloatermNew<cr>", "New Floaterm" },
	["<F8>"] = { "<cmd>FloatermNext<cr>", "Next Floaterm" },
	["<F9>"] = { "<cmd>FloatermPrev<cr>", "Prev Floaterm" },
	["<F10>"] = { "<cmd>lua require'dap'.step_over()<CR>", "DAP Step over" },
	["<F11>"] = { "<cmd>lua require'dap'.step_into()<CR>", "DAP Step into" },
	["<F12>"] = { "<cmd>FloatermToggle<cr>", "Toggle Floaterm" },
}

local gopts = {
	mode = "n", -- NORMAL mode
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

whichkey.register(mappings, opts)
whichkey.register(vmappings, vopts)
whichkey.register(global_mappings, gopts)
