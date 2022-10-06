local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

nvim_tree.setup({
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
	disable_netrw = true,
	respect_buf_cwd = true,
	sync_root_with_cwd = true,
	view = {
		adaptive_size = true,
	},
	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = {},
	},
})
