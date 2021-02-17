local fn = vim.fn
local api = vim.api

local M = {}

-- possible values are 'arrow' | 'rounded' | 'blank'
local active_sep = 'blank'

-- change them if you want to different separator
M.separators = {
  arrow = { '', '' },
  rounded = { '', '' },
  blank = { '', '' },
}

-- highlight groups
M.colors = {
  active        = '%#StatusLine#',
  inactive      = '%#StatuslineNC#',
  mode          = '%#Mode#',
  mode_alt      = '%#ModeAlt#',
  git           = '%#Git#',
  git_alt       = '%#GitAlt#',
  filetype      = '%#Filetype#',
  filetype_alt  = '%#FiletypeAlt#',
  line_col      = '%#LineCol#',
  line_col_alt  = '%#LineColAlt#',
  string        = '%#String#',
  diff_text     = '%#DiffText#',
  diff_add      = '%#DiffAdd#',
  diff_change   = '%#DiffChange#',
  wild_menu     = '%#WildMenu#',
  matchparen    = '%#MatchParen#',
  search        = '%#Search#',
  diff_delete   = '%#DiffDelete#',
  todo          = '%#Todo#',
  inc_search    = '%#IncSearch#'
}

local modes = {
  ['n']  = {'Normal', 'N', M.colors.mode};
  ['no'] = {'N·Pending', 'N·P', M.colors.mode} ;
  ['v']  = {'Visual', 'V', M.colors.diff_text};
  ['V']  = {'V·Line', 'V·L', M.colors.diff_text};
  [''] = {'V·Block', 'V·B', M.colors.diff_text}; -- this is not ^V, but it's , they're different
  ['s']  = {'Select', 'S', M.colors.wild_menu};
  ['S']  = {'S·Line', 'S·L', M.colors.wild_menu};
  [''] = {'S·Block', 'S·B', M.colors.wild_menu}; -- same with this one, it's not ^S but it's 
  ['i']  = {'Insert', 'I', M.colors.diff_add};
  ['ic'] = {'Insert', 'I', M.colors.diff_add};
  ['R']  = {'Replace', 'R', M.colors.diff_delete};
  ['Rv'] = {'V·Replace', 'V·R', M.colors.diff_delete};
  ['c']  = {'Command', 'C', M.colors.search};
  ['cv'] = {'Vim·Ex ', 'V·E', M.colors.matchparen};
  ['ce'] = {'Ex ', 'E', M.colors.matchparen};
  ['r']  = {'Prompt ', 'P', M.colors.todo};
  ['rm'] = {'More ', 'M', M.colors.todo};
  ['r?'] = {'Confirm ', 'C', M.colors.todo};
  ['!']  = {'Shell ', 'S', M.colors.inc_search};
  ['t']  = {'Terminal ', 'T', M.colors.diff_add};
}

M.is_truncated = function(_, width)
  local current_width = api.nvim_win_get_width(0)
  return current_width < width
end

M.get_current_mode = function(self)
  local current_mode = api.nvim_get_mode().mode

  if self:is_truncated(80) then
    return string.format(' %s ', modes[current_mode][2]):upper()
  end
  return string.format(' %s ', modes[current_mode][1]):upper()
end

M.get_current_mode_color = function(self)
  local current_mode = api.nvim_get_mode().mode
  return modes[current_mode][3]
end

M.get_git_branch = function(self)
	local branch = vim.fn['fugitive#head'](7)
  local is_empty = branch ~= ''
  local short_name = branch:len() > 20 and branch:sub(1, 20)..'...' or branch

  if self:is_truncated(90) then
    return is_empty and string.format('  %s ', short_name '') or ''
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


M.set_active = function(self)
  local colors = self.colors

  local mode = self.get_current_mode_color() .. self:get_current_mode()
  local mode_alt = colors.mode_alt .. self.separators[active_sep][1]
  local git = colors.git .. self:get_git_branch()
  local git_alt = colors.git_alt .. self.separators[active_sep][1]
  local filename = colors.inactive .. self:get_filename()
  local filetype_alt = colors.filetype_alt .. self.separators[active_sep][2]
  local filetype = colors.filetype .. self:get_filetype()
  local line_col = colors.line_col .. self:get_line_col()
  local line_col_alt = colors.line_col_alt .. self.separators[active_sep][2]

  return table.concat({
    colors.string, ' %n ', colors.active, mode, mode_alt, git, git_alt,
    colors.inactive, "%=", filename, "%=",
    filetype_alt, filetype, line_col_alt, line_col
  })
end

M.set_inactive = function(self)
  return self.colors.inactive .. '%= %F %='
end

M.set_explorer = function(self)
  local title = self.colors.mode .. '   '
  local title_alt = self.colors.mode_alt .. self.separators[active_sep][2]

  return table.concat({ self.colors.active, title, title_alt })
end

Statusline = setmetatable(M, {
  __call = function(statusline, mode)
    if mode == "active" then return statusline:set_active() end
    if mode == "inactive" then return statusline:set_inactive() end
    if mode == "explorer" then return statusline:set_explorer() end
  end
})

-- set statusline
-- TODO: replace this once we can define autocmd using lua
vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline('explorer')
  augroup END
]], false)
