local fn = vim.fn
local api = vim.api

local M = {}

-- possible values are 'arrow' | 'rounded' | 'blank'
local active_sep = 'angle'

-- change them if you want to different separator
M.separators = {
  arrow = { '', '' },
  rounded = { '', '' },
  angle = { '', '' },
  blank = { '', '' },
}

-- set highlights
vim.api.nvim_exec([[
  highlight STDefault guifg=#bbc2cf guibg=#202328
  highlight STRed guifg=#f8f8ff guibg=#ec5f67
  highlight STGreen guifg=#f8f8ff guibg=#00FF7F
  highlight STYellow guifg=#f8f8ff guibg=#ecbe7b
  highlight STBlue guifg=#f8f8ff guibg=#1E90FF
  highlight STCyan guifg=#f8f8ff guibg=#008080
  highlight STMagenta guifg=#f8f8ff guibg=#c678dd
  highlight STViolet guifg=#f8f8ff guibg=#4B0082
  highlight STOrange guifg=#f8f8ff guibg=#FF8800
  highlight STDarkgray guifg=#f8f8ff guibg=#2F4F4F

  highlight STRedfg guibg=#202328 guifg=#ec5f67
  highlight STGreenfg guibg=#202328 guifg=#00FF7F
  highlight STYellowfg guibg=#202328 guifg=#ecbe7b
  highlight STBluefg guibg=#008080 guifg=#1E90FF
  highlight STCyanfg guibg=#202328 guifg=#008080
  highlight STMagentafg guibg=#202328 guifg=#c678dd
  highlight STVioletfg guibg=#FF8800 guifg=#4B0082
  highlight STOrangefg guibg=#202328 guifg=#FF8800
  highlight STDarkgrayfg guibg=#FF8800 guifg=#2F4F4F
]], false)

-- highlight groups
M.colors = {
  active        = '%#STDefault#',
  inactive      = '%#STDefault#',
  mode          = '%#STViolet#',
  mode_alt      = '%#STVioletfg#',
  git           = '%#STOrange#',
  git_alt       = '%#STOrangefg#',
  filetype      = '%#STCyan#',
  filetype_alt  = '%#STCyanfg#',
  line_col      = '%#STBlue#',
  line_col_alt  = '%#STBluefg#',
  paste         = '%#STRed#'
}

local modes = {
  ['n']  = {'Normal', 'N'};
  ['no'] = {'N·Pending', 'N·P'};
  ['v']  = {'Visual', 'V'};
  ['V']  = {'V·Line', 'V·L'};
  [''] = {'V·Block', 'V·B'};
  ['s']  = {'Select', 'S'};
  ['S']  = {'S·Line', 'S·L'};
  [''] = {'S·Block', 'S·B'};
  ['i']  = {'Insert', 'I'};
  ['ic'] = {'Insert', 'I'};
  ['R']  = {'Replace', 'R'};
  ['Rv'] = {'V·Replace', 'V·R'};
  ['c']  = {'Command', 'C'};
  ['cv'] = {'Vim·Ex ', 'V·E'};
  ['ce'] = {'Ex ', 'E'};
  ['r']  = {'Prompt ', 'P'};
  ['rm'] = {'More ', 'M'};
  ['r?'] = {'Confirm ', 'C'};
  ['!']  = {'Shell ', 'S'};
  ['t']  = {'Terminal ', 'T'};
}

M.is_truncated = function(_, width)
  local current_width = api.nvim_win_get_width(0)
  return current_width < width
end

M.get_current_mode = function(self)
  local current_mode = api.nvim_get_mode().mode

  if self:is_truncated(80) then
    return string.format(' גּ %s ', modes[current_mode][2]):upper()
  end
  return string.format(' גּ %s ', modes[current_mode][1]):upper()
end

M.get_git_branch = function(self)
	local branch = vim.fn['fugitive#head'](7)
  local is_empty = branch ~= ''
  local short_name = branch:len() > 20 and branch:sub(1, 20)..'...' or branch

  if self:is_truncated(90) then
    return is_empty and string.format('  %s ', short_name or '') or ''
  end

  return is_empty
    and string.format(
      '  %s ',
      short_name
    )
    or ''
end

M.get_filename = function(self)
  local is_modified = vim.bo.modified and ' ✘ ' or ''
  if self:is_truncated(140) then return " %<%f"..is_modified end
  return " %<%F"..is_modified
end

M.get_filetype = function()
  local file_name, file_ext = fn.expand("%:t"), fn.expand("%:e")
  local icon = require'nvim-web-devicons'.get_icon(file_name, file_ext, { default = true })
  local filetype = vim.bo.filetype

  if filetype == '' then return '' end
  return string.format(' %s %s ', icon, filetype):lower()
end

M.get_line_col = function(self)
  if self:is_truncated(60) then return ' %l:%c ' end
  return ' Ln %l, Col %c '
end

M.paste = function(self)
  if vim.o.paste then return '  PASTE ' end
  return ''
end


M.set_active = function(self)
  local colors = self.colors

  local mode = colors.mode .. self:get_current_mode()
  local mode_alt = colors.mode_alt .. self.separators[active_sep][1]
  local paste = colors.paste .. self:paste()
  local git = colors.git .. self:get_git_branch()
  local git_alt = colors.git_alt .. self.separators[active_sep][1]
  local filename = colors.inactive .. self:get_filename()
  local filetype_alt = colors.filetype_alt .. self.separators[active_sep][2]
  local filetype = colors.filetype .. self:get_filetype()
  local line_col = colors.line_col .. self:get_line_col()
  local line_col_alt = colors.line_col_alt .. self.separators[active_sep][2]

  return table.concat({
    colors.active, ' %n ', paste, mode, mode_alt, git, git_alt,
    colors.inactive, "%=", filename, "%=",
    filetype_alt, filetype, line_col_alt, line_col
  })
end

M.set_inactive = function(self)
  return self.colors.inactive .. '%= %F %='
end

M.set_explorer = function(self)
  local title = self.colors.mode .. '   '

  return table.concat({ self.colors.active, title, self.colors.active, ' FILE EXPLORER ' })
end

Statusline = setmetatable(M, {
  __call = function(statusline, mode)
    if mode == "active" then return statusline:set_active() end
    if mode == "inactive" then return statusline:set_inactive() end
    if mode == "explorer" then return statusline:set_explorer() end
  end
})

-- set statusline
vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline('explorer')
  augroup END
]], false)
