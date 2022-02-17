local api = vim.api

-- Highlight on yank
api.nvim_exec(
	[[
    augroup YankHighlight
      autocmd!
      autocmd TextYankPost * silent! lua vim.highlight.on_yank()
    augroup end
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
