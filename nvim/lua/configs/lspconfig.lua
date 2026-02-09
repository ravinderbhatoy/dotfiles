local lspconfig = require("lspconfig")
local defaults = require("nvchad.configs.lspconfig")

local on_attach = defaults.on_attach
local capabilities = defaults.capabilities

-- Python
lspconfig.pylsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          enabled = true,
          ignore = { "E501" },
        },
      },
    },
  },
}

-- TypeScript / React
lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Tailwind / NativeWind
lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "html",
    "css",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
}

-- ESLint
lspconfig.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
