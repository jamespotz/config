local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set("n", "O", "", { buffer = bufnr })
	vim.keymap.del("n", "O", { buffer = bufnr })
	vim.keymap.set("n", "<2-RightMouse>", "", { buffer = bufnr })
	vim.keymap.del("n", "<2-RightMouse>", { buffer = bufnr })
	vim.keymap.set("n", "D", "", { buffer = bufnr })
	vim.keymap.del("n", "D", { buffer = bufnr })
	vim.keymap.set("n", "E", "", { buffer = bufnr })
	vim.keymap.del("n", "E", { buffer = bufnr })

	vim.keymap.set("n", "A", api.tree.expand_all, opts("Expand All"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "P", function()
		local node = api.tree.get_node_under_cursor()
		print(node.absolute_path)
	end, opts("Print Node Path"))

	vim.keymap.set("n", "Z", api.node.run.system, opts("Run System"))
end

nvimtree.setup({
	on_attach = function(bufnr)
		on_attach(bufnr)
		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end
		local ok, api = pcall(require, "nvim-tree.api")
		assert(ok, "api module is not found")
		vim.keymap.set("n", "<CR>", api.node.open.tab_drop, opts("Tab drop"))
	end,
	live_filter = {
		prefix = "[FILTER]: ",
		always_show_folders = false, -- Turn into false from true by default
	},
	view = {
		float = {
			enable = true,
			open_win_config = function()
				local screen_w = vim.opt.columns:get()
				local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
				local window_w = screen_w * WIDTH_RATIO
				local window_h = screen_h * HEIGHT_RATIO
				local window_w_int = math.floor(window_w)
				local window_h_int = math.floor(window_h)
				local center_x = (screen_w - window_w) / 2
				local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
				return {
					border = "rounded",
					relative = "editor",
					row = center_y,
					col = center_x,
					width = window_w_int,
					height = window_h_int,
				}
			end,
		},
		width = function()
			return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
		end,
	},
	tab = {
		sync = {
			close = true,
		},
	},
	update_focused_file = {
		enable = true,
	},
	diagnostics = {
		enable = true,
	},
})

-- This will:
--
-- Close the tab if nvim-tree is the last buffer in the tab (after closing a buffer)
-- Close vim if nvim-tree is the last buffer (after closing a buffer)
-- Close nvim-tree across all tabs when one nvim-tree buffer is manually closed if and only if tabs.sync.close is set
local function tab_win_closed(winnr)
	local api = require("nvim-tree.api")
	local tabnr = vim.api.nvim_win_get_tabpage(winnr)
	local bufnr = vim.api.nvim_win_get_buf(winnr)
	local buf_info = vim.fn.getbufinfo(bufnr)[1]
	local tab_wins = vim.tbl_filter(function(w)
		return w ~= winnr
	end, vim.api.nvim_tabpage_list_wins(tabnr))
	local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
	if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
		-- Close all nvim tree on :q
		if not vim.tbl_isempty(tab_bufs) then -- and was not the last window (not closed automatically by code below)
			api.tree.close()
		end
	else -- else closed buffer was normal buffer
		if #tab_bufs == 1 then -- if there is only 1 buffer left in the tab
			local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
			if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
				vim.schedule(function()
					if #vim.api.nvim_list_wins() == 1 then -- if its the last buffer in vim
						vim.cmd("quit") -- then close all of vim
					else -- else there are more tabs open
						vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
					end
				end)
			end
		end
	end
end

vim.api.nvim_create_autocmd("WinClosed", {
	callback = function()
		local winnr = tonumber(vim.fn.expand("<amatch>"))
		vim.schedule_wrap(tab_win_closed(winnr))
	end,
	nested = true,
})
