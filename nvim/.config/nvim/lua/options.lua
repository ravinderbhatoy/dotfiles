require "nvchad.options"
local opt = vim.opt

-- Set the maximum width for text to 80 characters
vim.opt.textwidth = 80

-- Enable soft wrapping
opt.wrap = true

-- Wrap lines at a character in 'breakat' (spaces, punctuation) instead of mid-word
opt.linebreak = true

-- Keep indentation structure when lines wrap visually
opt.breakindent = true

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.o.relativenumber = true
-- vim.diagnostic.config {
--   underline = false,
-- }
--
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
  undercurl = true,
  sp = "#E06C75", -- soft red
})
