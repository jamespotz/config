local status_ok, dapjs = pcall(require, "dap-vscode-js")
if not status_ok then
	return
end

dapjs.setup({
	-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
	require("dap").configurations[language] = {
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Launch chrome",
			url = "https://localhost:3005",
			webRoot = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Next",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
	}
end

vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🟦", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", linehl = "", numhl = "" })
