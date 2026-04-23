local defaults = require "nvchad.configs.lspconfig"

-- C/C++
vim.lsp.config("clangd", {
  on_attach = defaults.on_attach,
  capabilities = defaults.capabilities,
})

-- Python
vim.lsp.config("pylsp", {
  on_attach = defaults.on_attach,
  capabilities = defaults.capabilities,
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
-- Go
vim.lsp.config("gopls", {
  on_attach = defaults.on_attach,
  capabilities = defaults.capabilities,
  settings = {
    gopls = {
      semanticTokens = true, -- this is the key line
    },
  },
})

vim.lsp.enable {
  "clangd",
  "pylsp",
  "ts_ls",
  "eslint",
  "jsonls",
  "tailwindCSS",
  "gopls",
}

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
