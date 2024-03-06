---@diagnostic disable-next-line: deprecated
table.unpack = table.unpack or unpack

local lspconfig = require "lspconfig"

local plugins_lsp_config = require "plugins.configs.lspconfig"

local on_attach = plugins_lsp_config.on_attach
local capabilities = plugins_lsp_config.capabilities
local on_init = plugins_lsp_config.on_init

-- nvim-ufo
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local default_config = {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
}

local server_configs = {
  "yamlls",

  ["tsserver"] = {
    init_options = {
      preferences = {
        importModuleSpecifierPreference = "non-relative",
      },
    },
  },
  ["eslint"] = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
    settings = require("custom.configs.util").eslint_settings,
  },
  ["bashls"] = {
    filetypes = { "sh", "zsh", "bash" },
  },
  ["clangd"] = {
    capabilities = vim.tbl_extend("force", capabilities, {
      offsetEncoding = "utf-16",
    }),
  },
  ["rust_analyzer"] = {
    settings = {
      ["rust-analyzer"] = {
        command = "clippy",
      },
    },
  },
}

for k, v in pairs(server_configs) do
  local server, config = table.unpack(
    type(k) == "number" and { v, default_config } or { k, vim.tbl_deep_extend("force", default_config, v) }
  )

  if server == "rust_analyzer" then
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {},
      -- LSP configuration
      server = config,
      -- DAP configuration
      dap = {},
    }
  else
    lspconfig[server].setup(config)
  end
end
