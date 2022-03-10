local status_ok, hop = pcall(require, "hop")
if not status_ok then
	return
end

hop.setup()
vim.api.nvim_set_keymap("", "f", ":HopChar2<cr>", { silent = true })
vim.api.nvim_set_keymap("", "F", ":HopWord<cr>", { silent = true })
