local function get_file_name()
	local ok, devicons = pcall(require, "nvim-web-devicons")
	local f_icon = ""
	local f_hl = ""
	if ok then
		f_icon, f_hl = devicons.get_icon_by_filetype(vim.bo.filetype)
	end -- if filetype doesn't match devicon will set f_icon to nil so add a patch
	f_icon = f_icon == nil and "" or (f_icon .. " ") -- No icon no space after separator
	f_hl = f_hl == nil and "" or f_hl
	return "%#" .. f_hl .. "#" .. f_icon .. "%*" .. "%#Normal#" .. vim.fn.expand("%:t") .. "%*"
end

local filetype_exclusions = {
	"help",
	"startify",
	"dashboard",
	"packer",
	"neo-tree",
	"neogitstatus",
	"NvimTree",
	"Trouble",
	"alpha",
	"lir",
	"Outline",
	"spectre_panel",
	"toggleterm",
	"DressingSelect",
	"Jaq",
	"harpoon",
	"dap-repl",
	"dap-terminal",
	"dapui_console",
	"lab",
	"Markdown",
	"notify",
	"noice",
	"",
}

local excludes = function()
	return vim.tbl_contains(filetype_exclusions or {}, vim.bo.filetype)
end

local group = vim.api.nvim_create_augroup("_winbar", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "CursorMoved", "WinLeave" }, {
	group = group,
	callback = function()
		if not excludes() then
			vim.o.winbar = get_file_name() .. " > %{%v:lua.require'nvim-navic'.get_location()%}"
		end
	end,
})
