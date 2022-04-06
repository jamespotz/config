local api = vim.api

-- Highlight on yank
api.nvim_exec(
	[[
    augroup highlight_yank
      autocmd!
      au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
    augroup END
  ]],
	false
)

-- Autoread
api.nvim_exec(
	[[
    autocmd FocusGained,BufEnter * :checktime
  ]],
	false
)
