local refactor = require("refactoring")
refactor.setup({})

-- telescope refactoring helper
local function refactor(prompt_bufnr)
  local content = require("telescope.actions.state").get_selected_entry(
    prompt_bufnr
  )
  require("telescope.actions").close(prompt_bufnr)
  require("refactoring").refactor(content.value)
end
-- NOTE: M is a global object
-- for the sake of simplicity in this example
-- you can extract this function and the helper above
-- and then require the file and call the extracted function
-- in the mappings below
M = {}
M.refactors = function()
  require("telescope.pickers").new({}, {
    prompt_title = "refactors",
    finder = require("telescope.finders").new_table({
      results = require("refactoring").get_refactors(),
    }),
    sorter = require("telescope.config").values.generic_sorter({}),
    attach_mappings = function(_, map)
      map("i", "<CR>", refactor)
      map("n", "<CR>", refactor)
      return true
    end
  }):find()
end

vim.api.nvim_set_keymap("v", "<Leader>re", [[ <Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<Leader>rf", [[ <Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<Leader>rt", [[ <Cmd>lua M.refactors()<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>log", [[ <Cmd> lua require('refactoring').debug.printf({below = true})<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>logb", [[ <Cmd> lua require('refactoring').debug.printf({below = false})<CR>]], {noremap = true, silent = true, expr = false})
