local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "typesript" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- custom
  b.formatting.rustfmt,
  b.code_actions.gitsigns,
  b.code_actions.eslint,
  b.diagnostics.cspell.with {
    extra_args = { "--config", "~/.config/cspell.json" },
  },
  b.code_actions.cspell.with {
    extra_args = { "--config", "~/.config/cspell.json" },
  },
}

null_ls.setup {
  debug = true,
  sources = sources,
}
