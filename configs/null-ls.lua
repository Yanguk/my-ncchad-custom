local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins
local cspell = require "cspell"
local cspell_config = require "custom.configs.cspell"

local sources = {
  b.formatting.prettier,
  b.formatting.stylua.with { filetypes = { "lua" } },
  b.formatting.shfmt,
  b.formatting.clang_format,

  cspell.diagnostics.with { config = cspell_config },
  cspell.code_actions.with { config = cspell_config },
}

null_ls.setup {
  sources = sources,
}
