local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end
--[[ math.randomseed(os.time()) ]]

local function pick_color(index)
	local colors = {
		"StartLogo1",
		"StartLogo1",
		"StartLogo2",
		"StartLogo2",
		"StartLogo3",
		"StartLogo3",
		"StartLogo4",
		"StartLogo4",
		"StartLogo4",
		"StartLogo4",
		"StartLogo5",
		"StartLogo5",
		"StartLogo5",
		"StartLogo5",
		"StartLogo5",
		"StartLogo5",
		"StartLogo5",
		"StartLogo5",
		"StartLogo5",
	}
	--[[ return colors[math.random(#colors)] ]]
	return colors[index]
end

local config = require("alpha.themes.theta").config
local dashboard = require("alpha.themes.dashboard")
local function button(sc, txt, keybind, keybind_opts)
	local b = dashboard.button(sc, txt, keybind, keybind_opts)
	b.opts.hl = "Function"
	b.opts.hl_shortcut = "Type"
	return b
end

local header = {
	"                                ▒▒                                ",
	"                                ▓▓                                ",
	"                                ▓▓▓▓                              ",
	"                                ████                              ",
	"                              ░░████                              ",
	"                              ██▓▓██                              ",
	"                        ░░  ████▓▓▓▓    ▒▒                        ",
	"                        ▓▓▒▒▓▓██▒▒▓▓  ██░░                        ",
	"                      ▓▓██████▒▒▓▓▒▒████  ▒▒                      ",
	"                      ██████▒▒▒▒▓▓▒▒██▒▒  ██                      ",
	"                      ██▓▓▓▓░░▒▒████▓▓░░▒▒██  ░░                  ",
	"                      ██▒▒▒▒░░▒▒▓▓██▓▓▓▓████▓▓░░                  ",
	"                      ██▒▒▒▒░░▒▒████▓▓██▓▓████░░                  ",
	"                      ██▒▒░░░░▒▒▓▓██▒▒██▒▒██▓▓░░                  ",
	"                  ░░  ▒▒▒▒░░░░░░▒▒██░░▒▒▒▒▓▓██                    ",
	"                    ██▓▓▓▓░░  ░░▒▒▒▒░░░░▒▒▓▓▓▓                    ",
	"                    ░░██▓▓▒▒░░  ░░░░░░░░░░▓▓░░                    ",
	"                      ░░▓▓░░░░        ░░▒▒░░                      ",
	"                          ░░▒▒░░      ░░                          ",
}

-- Map over the headers, setting a different color for each line.
-- This is done by setting the Highligh to StartLogoN, where N is the row index.
-- Define StartLogo1..StartLogoN to get a nice gradient.
local function header_color()
	local lines = {}
	for i, line_chars in pairs(header) do
		local line = {
			type = "text",
			val = line_chars,
			opts = {
				hl = pick_color(i),
				shrink_margin = false,
				position = "center",
			},
		}
		table.insert(lines, line)
	end

	local output = {
		type = "group",
		val = lines,
		opts = { position = "center" },
	}

	return output
end

--[[ dashboard.section.header.opts.hl = pick_color() ]]
--[[]]
config.layout[6].val = {
	button("<Space>f", "  File Explorer", ":NvimTreeToggle<CR>"),
	button("<Space>p", " Open Projects", ":Telescope projects<CR>"),
	button("<Space>r", "  Recent", ":Telescope oldfiles<CR>"),
	button("<Space>n", "ﱐ  New file", ":ene <BAR> startinsert<CR>"),
	button("<Space>v", "  Config", ":e $MYVIMRC<CR>"),
	button("<Space>u", "ﮮ  Update plugins", ":PackerUpdate<CR>"),
	button("q", "✘  Quit", ":qa<CR>"),
}

config.layout[2] = header_color()
alpha.setup(config)
