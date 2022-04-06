local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

dap.adapters.chrome = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/vscode-chrome-debug/out/src/chromeDebug.js" }, -- TODO adjust
}

dap.configurations.javascript = {
	{
		type = "chrome",
		request = "launch",
		-- port = 9222,
		url = "https://localhost:3005",
		webRoot = "${workspaceFolder}/src",
	},
}

vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🟦", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", linehl = "", numhl = "" })

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<F5>", ':lua require"dap".continue()<CR>')
map("n", "<F8>", ':lua require"dap".step_over()<CR>')
map("n", "<F9>", ':lua require"dap".step_into()<CR>')
map("n", "<F10>", ':lua require"dap".step_out()<CR>')
map("n", "<leader>tb", ':lua require"dap".toggle_breakpoint()<CR>')
map("n", "<leader>lp", ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
map("n", "<leader>dr", ':lua require"dap".repl.toggle()<CR>')
map("n", "<leader>tx", ':lua require"dap".terminate()<CR>')
