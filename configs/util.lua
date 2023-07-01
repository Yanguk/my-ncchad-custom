local M = {}

local function get_eslint_settings()
  local eslint_settings = {}

  local yarn_path = vim.fn.getcwd() .. "/.yarn"
  local is_yarn_pnp = vim.fn.isdirectory(yarn_path) == 1

  if is_yarn_pnp then
    eslint_settings = {
      nodePath = vim.fn.getcwd() .. "/.yarn/sdks",
      packageManager = "yarn",
    }
  end

  return eslint_settings
end

M.eslint_settings = get_eslint_settings()

return M
