local lspconfig = require "lspconfig"

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
-- nvim-ufo
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local util = require "custom.configs.util"

lspconfig["tsserver"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "non-relative",
    },
  },
}

lspconfig["eslint"].setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  capabilities = capabilities,
  settings = util.eslint_settings,
}

lspconfig["bashls"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "sh", "zsh", "bash" },
}

lspconfig["yamlls"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig["clangd"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {},
  -- LSP configuration
  server = {
    on_attach = on_attach,
    settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {
        command = "clippy",
        -- overrideCommand = {
        --   "cargo",
        --   "clippy",
        --   "--fix",
        --   "--workspace",
        --   "--message-format=json",
        --   "--all-targets",
        --   "--allow-dirty",
        -- },
      },
    },
  },
  -- DAP configuration
  dap = {},
}
