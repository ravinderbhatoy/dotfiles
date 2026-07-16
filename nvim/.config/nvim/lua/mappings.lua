require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

-- Move line up (Normal mode)
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Move line down (Normal mode)
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down" })

-- Move selection up/down (Visual mode - highly recommended)
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

map("n", "gl", function()
  vim.diagnostic.open_float(nil, { focus = false })
end, { desc = "Line Diagnostics" })
