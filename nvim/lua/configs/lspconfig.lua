require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "clangd", "pylsp", "tsserver" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
--
vim.lsp.config("pylsp", {
  settings = {
    pylsp = { -- This second 'pylsp' key is necessary for the settings to be applied correctly
      plugins = {
        pycodestyle = {
          enabled = true,
          ignore = { "E501" }, -- Ignore the "line too long" error code
        },
      },
    },
  },
})
