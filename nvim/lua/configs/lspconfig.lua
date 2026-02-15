local defaults = require("nvchad.configs.lspconfig")

-- C/C++
vim.lsp.config("clangd", {
  on_attach = defaults.on_attach,
  capabilities = defaults.capabilities,
})

-- Python
vim.lsp.config("pylsp", {
  on_attach = defaults.on_attach,
  capabilities = defaults.capabilities,
  -- settings = {
  --   pylsp = {
  --     plugins = {
  --       pycodestyle = {
  --         enabled = true,
  --         ignore = { "E501" }, -- must be uppercase
  --       },
  --       pyflakes = { enabled = true },
  --       mccabe = { enabled = true },
  --     },
  --   },
  -- },
})

-- TypeScript / React Native
vim.lsp.config("ts_ls", {
  on_attach = defaults.on_attach,
  capabilities = defaults.capabilities,
})

-- ESLint
vim.lsp.config("eslint", {
  on_attach = defaults.on_attach,
  capabilities = defaults.capabilities,
})

-- JSON (important for React Native projects)
vim.lsp.config("jsonls", {
  on_attach = defaults.on_attach,
  capabilities = defaults.capabilities,
})

vim.lsp.enable({
  "clangd",
  "pylsp",
  "ts_ls",
  "eslint",
  "jsonls",
})

vim.lsp.config("tailwindcss", {
  on_attach = defaults.on_attach,
  capabilities = defaults.capabilities,
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "style" },
    },
  },
})

vim.lsp.enable({ "tailwindcss" })
