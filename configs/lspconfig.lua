local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "rust_analyzer", "eslint" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.tsserver.setup {
  init_options = {
    hostInfo = "neovim",
    preferences = {
      importModuleSpecifierPreference = "non-relative",
    },
  },
}

local eslint_settings = {}

local function has_yarn_folder()
  local yarn_path = vim.fn.getcwd() .. "/.yarn"
  return vim.fn.isdirectory(yarn_path) == 1
end

if has_yarn_folder() then
  eslint_settings = {
    nodePath = vim.fn.getcwd() .. "/.yarn/sdks",
    packageManager = "yarn",
  }
end

lspconfig.eslint.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  settings = eslint_settings,
}
