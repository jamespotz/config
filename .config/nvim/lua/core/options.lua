local fn = vim.fn
local opt = vim.opt
local cmd = vim.cmd

-- Disable some builtin plugins.
local disabled_built_ins = {
	"2html_plugin",
	"gzip",
	"matchit",
	"rrhelper",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"logipat",
	"spellfile_plugin",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

-- Creates undo directory
local undo_dir = fn.expand("~/.undo")
if fn.isdirectory(undo_dir) == 0 then
	fn.mkdir(undo_dir, "p")
end

local load_defaults = function()
	local default_options = {
		backspace = { "indent", "eol", "start" },
		backup = false, -- creates a backup file
		clipboard = "unnamedplus", -- allows neovim to access the system clipboard
		cmdheight = 2, -- more space in the neovim command line for displaying messages
		colorcolumn = "80",
		conceallevel = 0, -- so that `` is visible in markdown files
		fileencoding = "utf-8", -- the encoding written to a file
		foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
		foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
		hidden = true, -- required to keep multiple buffers and open multiple buffers
		hlsearch = true, -- highlight all matches on previous search pattern
		ignorecase = true, -- ignore case in search patterns
		mouse = "a", -- allow the mouse to be used in neovim
		pumheight = 10, -- pop up menu height
		pumblend = 20, -- pop up menu transparency
		winblend = 20, -- floating window transparency
		showmode = false, -- we don't need to see things like -- INSERT -- anymore
		showtabline = 2, -- always show tabs
		smartcase = true, -- smart case
		smartindent = true, -- make indenting smarter again
		splitbelow = true, -- force all horizontal splits to go below current window
		splitright = true, -- force all vertical splits to go to the right of current window
		swapfile = false, -- creates a swapfile
		termguicolors = true, -- set term gui colors (most terminals support this)
		title = true, -- set the title of window to the value of the titlestring
		undodir = undo_dir, -- set the undo directory to be saved
		undofile = true, -- enable persistent undo
		updatetime = 250, -- faster completion
		writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
		expandtab = true, -- convert tabs to spaces
		shiftwidth = 2, -- the number of spaces inserted for each indentation
		tabstop = 2, -- insert 2 spaces for a tab
		cursorline = true, -- highlight the current line
		number = true, -- set numbered lines
		relativenumber = true, -- set relative numbered lines
		numberwidth = 4, -- set number column width to 2 {default 4}
		signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
		wrap = false, -- display lines as one long line
		spell = true,
		spelllang = { "en_us" },
		scrolloff = 8,
		sidescrolloff = 8,
		wildmenu = true,
		wildmode = "full",
		wildcharm = fn.char2nr("^I"), -- tab completion for the wildmenu
		lazyredraw = true, -- Only redraw when necessary
		inccommand = "nosplit", -- Show incremental live substitution
		textwidth = 80,
		shell = "/usr/bin/zsh",
		list = true,
		listchars = { eol = "↴" },
		guifont = "VictorMono NF:h12:b",
	}

	---  SETTINGS  ---

	opt.shortmess:append("c")

	for k, v in pairs(default_options) do
		opt[k] = v
	end
end

load_defaults()

cmd([[colorscheme tokyonight]])

-- Neovide config
vim.g.neovide_refresh_rate = 144
