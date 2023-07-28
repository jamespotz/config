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

-- Neovide
if vim.g.neovide then
  local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  end

  vim.g.transparency = 0.9
  vim.g.neovide_transparency = 0.9
  vim.g.neovide_background_color = "#0f1117" .. alpha()
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
end
