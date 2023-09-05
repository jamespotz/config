local status_ok, formatter = pcall(require, "formatter")

if not status_ok then
	return
end

local defaults = require("formatter.defaults")
local prettier = defaults.prettierd
local eslint_d = defaults.eslint_d
local stylua = require("formatter.filetypes.lua").stylua

formatter.setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	filetype = {
		css = { prettier },
		scss = { prettier },
		html = { prettier },
		javascript = { prettier, eslint_d },
		javascriptreact = { prettier, eslint_d },
		typescript = { prettier, eslint_d },
		typescriptreact = { prettier, eslint_d },
		markdown = { prettier },
		json = { prettier },
		jsonc = { prettier },
		lua = { stylua },
	},
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	command = "FormatWrite",
})
