local configs = {
	lazy = {},
	start = {},
}

local Plug = {
	begin = vim.fn["plug#begin"],

	ends = function()
		vim.fn["plug#end"]()

		for i, config in pairs(config.start) do
			config()
		end
	end,
}

_G.VimPlugApplyConfig = function(plugin_name)
	local fn = configs.lazy[plugin_name]
	if type(fn) == "function" then
		fn()
	end
end

local plug_name = function(repo)
	return repo:match("^[%w-]+/([%w-_.]+)$")
end

local meta = {

	__call = function(self, repo, opts)
		opts = opts or vim.empty_dict()

		opts["do"] = opts.run
		opts.run = nil

		opts["for"] = opts.ft
		opts.ft = nil

		vim.call("plug#", repo, opts)

		if type(opts.config) == "function" then
			local plugin = opts.as or plug_name(repo)

			if opts["for"] == nil and opts.on == nil then
				configs.start[plugin] = opts.config
			else
				configs.lazy[plugin] = opts.config

				local user_cmd = [[ autocmd! User %s ++once lua VimPlugApplyConfig('%s') ]]
				vim.cmd(user_cmd:format(plugin, plugin))
			end
		end
	end,
}

return setmetatable(Plug, meta)
