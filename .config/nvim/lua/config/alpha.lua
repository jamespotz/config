local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end
math.randomseed(os.time())

local function pick_color()
	local colors = { "String", "Identifier", "Keyword", "Number" }
	return colors[math.random(#colors)]
end

local dashboard = require("alpha.themes.dashboard")
local function button(sc, txt, keybind, keybind_opts)
	local b = dashboard.button(sc, txt, keybind, keybind_opts)
	b.opts.hl = "Function"
	b.opts.hl_shortcut = "Type"
	return b
end

dashboard.section.header.val = {
	"██████████████████              ██████████████████",
	"  ████████████████    ██  ██    ████████████████  ",
	"    ████████████████  ██████  ████████████████    ",
	"      ██████████████████████████████████████      ",
	"        ██████████████████████████████████        ",
	"        ██████████████████████████████████        ",
	"        ██████████████████████████████████        ",
	"              ██████████████████████              ",
	"                  ██████████████                  ",
	"                      ██████                      ",
	"                        ██",
}

dashboard.section.header.opts.hl = pick_color()

dashboard.section.buttons.val = {
	button("<Space>f", "  File Explorer", ":NvimTreeToggle toggle<CR>"),
	button("<Space>p", " Open Projects", ":Telescope projects<CR>"),
	button("<Space>r", "  Recent", ":Telescope oldfiles<CR>"),
	button("<Space>n", "ﱐ  New file", ":ene <BAR> startinsert<CR>"),
	button("<Space>v", "  Config", ":e $MYVIMRC<CR>"),
	button("<Space>u", "ﮮ  Update plugins", ":PackerUpdate<CR>"),
	button("q", "✘  Quit", ":qa<CR>"),
}

alpha.setup(dashboard.opts)
