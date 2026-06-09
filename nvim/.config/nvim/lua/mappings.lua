require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

-- Move line up (Normal mode)
map("n", "<A-k>", ":MoveLine(-1)<CR>", { desc = "Move line up" })

-- Move line down (Normal mode)
map("n", "<A-j>", ":MoveLine(1)<CR>", { desc = "Move line down" })

map("n", "gl", function()
  vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Line Diagnostics" })
