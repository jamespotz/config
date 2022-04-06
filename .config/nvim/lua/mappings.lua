vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = function(mode, lhs, rhs, options)
	local opts = { noremap = true }
	for k, v in pairs(options or {}) do
		opts[k] = v
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

--Remap space as leader key
map("", "<Space>", "<Nop>", { silent = true })

--Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Y yank until the end of line  (note: this is now a default on master)
map("n", "Y", "y$")

-- Common Keymaps
map("i", "<C-c>", "<esc>")
map("n", "R", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gc<Left><Left><Left>")
map("n", "<Leader>,", ":nohlsearch<CR>")
map("n", "$", "$1")

-- Center when navigating search results
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Easy select all of file
map("n", "<Leader>sa", "ggVG<c-$>")

-- Move current line with Alt+j/k
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Stay in indent mode
map("v", "<", "<gv", { silent = true })
map("v", ">", ">gv", { silent = true })

map("n", "/", "/\\v")
