require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

map("n", "gl", function()
  vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Line Diagnostics" })
