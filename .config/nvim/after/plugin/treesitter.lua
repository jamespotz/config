local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

require("nvim-treesitter.install").compilers = { "gcc" }
treesitter_configs.setup({
	ensure_installed = {
		"javascript",
		"yaml",
		"lua",
		"bash",
		"graphql",
		"html",
		"css",
		"json",
		"markdown",
		"scss",
		"typescript",
		"dockerfile",
		"todotxt",
		"vue",
		"regex",
		"gitignore",
		"diff",
		"comment",
		"vim",
		"markdown_inline",
	},

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	indent = {
		enable = true,
		disable = { "yaml" },
	},

	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
	},

	autotag = { enable = true },
	rainbow = {
		enable = true,
		disable = { "html" },
		extended_mode = true,
		max_file_lines = nil,
	},

	context_commentstring = {
		enable = true,
		enable_autocmd = false,
		config = {
			-- Languages that have a single comment style
			typescript = "// %s",
			css = "/* %s */",
			scss = "/* %s */",
			html = "<!-- %s -->",
			svelte = "<!-- %s -->",
			vue = "<!-- %s -->",
			json = "",
		},
	},

	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		swap = {
			enable = true,
		},
	},

	-- auto install above language parsers
	auto_install = true,
})
