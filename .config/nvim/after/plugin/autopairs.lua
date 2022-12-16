local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
	return
end

local cmp_status, cmp = pcall(require, "cmp")
local cmp_autopairs_status, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

if not cmp_autopairs_status or not cmp_status then
	return
end

npairs.setup({
	check_ts = true,
	ts_config = {
		lua = { "string" },
		javascript = { "template_string" },
	},
})
require("nvim-autopairs.rule")
require("nvim-autopairs.conds")
require("nvim-autopairs.utils")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
