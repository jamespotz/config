vim.loader.enable()

local load = function(module_name)
	package.loaded[module_name] = nil
	require(module_name)
end

-- All non plugin related (vim) options
load("core.options")
-- Vim mappings, see lua/config/which.lua for more mappings
load("core.mappings")
-- Plugin management via Packer
load("core.lazy")
-- Vim autocommands/autogroups
load("core.autocmd")
-- Vim commands
load("core.commands")
