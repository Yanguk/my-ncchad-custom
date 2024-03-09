local null_ls = require("null-ls")

local b = null_ls.builtins
local cspell = require "cspell"
local cspell_config = require "custom.configs.cspell"

local taplo = require "custom.configs.taplo"

local sources = {
  b.formatting.prettier,
  b.formatting.stylua.with { filetypes = { "lua" } },
  b.formatting.shfmt,
  b.formatting.clang_format,
  b.formatting.raco_fmt,

  cspell.diagnostics.with { config = cspell_config },
  cspell.code_actions.with { config = cspell_config },
  taplo.formatting,
}

null_ls.setup {
  sources = sources,
}
