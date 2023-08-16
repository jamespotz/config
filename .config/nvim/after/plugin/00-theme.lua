-- Colorscheme
local status_ok, _tokyonight = pcall(require, "tokyonight")
if not status_ok then
	return
end

vim.cmd([[colorscheme tokyonight-night]])
