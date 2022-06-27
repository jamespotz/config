local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

nvim_tree.setup({
	respect_buf_cwd = true,
	update_cwd = true,
	disable_netrw = true,
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	view = {
		adaptive_size = true,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
})
