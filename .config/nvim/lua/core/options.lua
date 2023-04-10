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
		background = "dark",
		backspace = { "indent", "eol", "start" },
		backup = false, -- creates a backup file
		cmdheight = 2, -- more space in the neovim command line for displaying messages
		colorcolumn = "80",
		conceallevel = 0, -- so that `` is visible in markdown files
		cursorline = true, -- highlight the current line
		emoji = false,
		expandtab = true, -- convert tabs to spaces
		fileencoding = "utf-8", -- the encoding written to a file
		foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
		foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
		formatoptions = {
			["1"] = true,
			["2"] = true, -- Use indent from 2nd line of a paragraph
			q = true, -- continue comments with gq"
			c = true, -- Auto-wrap comments using textwidth
			r = true, -- Continue comments when pressing Enter
			n = true, -- Recognize numbered lists
			t = false, -- autowrap lines using text width value
			j = true, -- remove a comment leader when joining lines.
			-- Only break if the line was not longer than 'textwidth' when the insert
			-- started and only at a white character that has been entered during the
			-- current insert command.
			l = true,
			v = true,
		},
		guifont = "VictorMono NF:h12:ub",
		hidden = true, -- required to keep multiple buffers and open multiple buffers
		hlsearch = true, -- highlight all matches on previous search pattern
		ignorecase = true, -- ignore case in search patterns
		inccommand = "nosplit", -- Show incremental live substitution
		lazyredraw = false, -- Only redraw when necessary
		laststatus = 3,
		list = true,
		mouse = "a", -- allow the mouse to be used in neovim
		mousefocus = true,
		mousemoveevent = true,
		mousescroll = { "ver:1", "hor:1" },
		number = true, -- set numbered lines
		numberwidth = 4, -- set number column width to 2 {default 4}
		pumblend = 0, -- pop up menu transparency
		pumheight = 10, -- pop up menu height
		relativenumber = true, -- set relative numbered lines
		scrolloff = 8,
		shell = "/usr/bin/zsh",
		shiftwidth = 2, -- the number of spaces inserted for each indentation
		showmode = false, -- we don't need to see things like -- INSERT -- anymore
		showtabline = 2, -- always show tabs
		sidescrolloff = 8,
		signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
		smartcase = true, -- smart case
		smartindent = true, -- make indenting smarter again
		spell = true,
		spelllang = { "en_us" },
		splitbelow = true, -- force all horizontal splits to go below current window
		splitright = true, -- force all vertical splits to go to the right of current window
		swapfile = false, -- creates a swapfile
		synmaxcol = 1024,
		tabstop = 2, -- insert 2 spaces for a tab
		termguicolors = true, -- set term gui colors (most terminals support this)
		textwidth = 80,
		title = true, -- set the title of window to the value of the titlestring
		undodir = undo_dir, -- set the undo directory to be saved
		undofile = true, -- enable persistent undo
		updatetime = 250, -- faster completion
		wildcharm = fn.char2nr("^I"), -- tab completion for the wildmenu
		wildmenu = true,
		wildmode = "full",
		winblend = 0, -- floating window transparency
		wrap = false, -- display lines as one long line
		writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
		wildoptions = "pum",
	}

	---  SETTINGS  ---
	opt.shortmess:append("c")

	-- Add asterisks in block comments
	opt.formatoptions:append({ "r" })

	opt.wildignore:append({ "*/node_modules/*" })
	opt.path:append({ "**" }) -- Finding files - Search down into subfolders

	opt.listchars:append({ eol = "↴", space = "⋅" })

	opt.clipboard:prepend({ "unnamedplus" })
	for k, v in pairs(default_options) do
		opt[k] = v
	end
end

load_defaults()

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Neovide config
vim.g.neovide_refresh_rate = 144
