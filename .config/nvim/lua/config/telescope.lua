local api = vim.api
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")
telescope.setup({
	defaults = {
		prompt_prefix = " 🔍",
		color_devicons = true,

		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		mappings = {
			i = {
				["<C-x>"] = false,
				["<C-q>"] = actions.send_to_qflist,
			},
		},
	},
	pickers = {
		find_files = {
			mappings = {
				n = {
					["cd"] = function(prompt_bufnr)
						local selection = require("telescope.actions.state").get_selected_entry()
						local dir = vim.fn.fnamemodify(selection.path, ":p:h")
						require("telescope.actions").close(prompt_bufnr)
						-- Depending on what you want put `cd`, `lcd`, `tcd`
						vim.cmd(string.format("silent lcd %s", dir))
					end,
				},
			},
		},
	},
})

telescope.load_extension("fzf")

--Keymaps
api.nvim_set_keymap(
	"n",
	"<leader>pb",
	[[<cmd>lua require('telescope.builtin').buffers()<CR>]],
	{ noremap = true, silent = true }
)
api.nvim_set_keymap(
	"n",
	"<leader>pf",
	[[<cmd>lua require('telescope.builtin').find_files()<CR>]],
	{ noremap = true, silent = true }
)
api.nvim_set_keymap(
	"n",
	"<leader>pbz",
	[[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
	{ noremap = true, silent = true }
)
api.nvim_set_keymap(
	"n",
	"<leader>ps",
	[[<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input("Search For 🔍 ")})<CR>]],
	{ noremap = true, silent = true }
)
api.nvim_set_keymap(
	"n",
	"<C-p>",
	[[<cmd>lua require('telescope.builtin').git_files()<CR>]],
	{ noremap = true, silent = true }
)
api.nvim_set_keymap(
	"n",
	"<leader>vh",
	[[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
	{ noremap = true, silent = true }
)
