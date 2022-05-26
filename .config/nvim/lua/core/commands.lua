function _G.ReloadConfig()
	local hls_status = vim.v.hlsearch
	for name, _ in pairs(package.loaded) do
		if name:match("^core") or name:match("^config") then
			require("plenary.reload").reload_module(name)
		end
	end

	dofile(vim.env.MYVIMRC)
	if hls_status == 0 then
		vim.opt.hlsearch = false
	end
	vim.notify("Config Reloaded Successfully...", nil, { title = "Config" })
end

vim.cmd("command! ReloadConfig lua ReloadConfig()")
