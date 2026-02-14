
local defaults = require("nvchad.configs.lspconfig")

vim.lsp.config("clangd", {
  on_attach = defaults.on_attach,
  capabilities = defaults.capabilities,
})

vim.lsp.config("pylsp", {
  on_attach = defaults.on_attach,
  capabilities = defaults.capabilities,

  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          enabled = true,
          ignore = { "E501" }, -- must be uppercase
        },
        pyflakes = { enabled = true },
        mccabe = { enabled = true },
      },
    },
  },
})

vim.lsp.config("tsserver", {
  on_attach = defaults.on_attach,
  capabilities = defaults.capabilities,
})

vim.lsp.config("tailwindcss", {
  on_attach = defaults.on_attach,
  capabilities = defaults.capabilities,
  filetypes = {
    "html",
    "css",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
})

vim.lsp.config("eslint", {
  on_attach = defaults.on_attach,
  capabilities = defaults.capabilities,
})


vim.lsp.enable({
  "clangd",
  "pylsp",
  "tsserver",
  "tailwindcss",
  "eslint",
})
