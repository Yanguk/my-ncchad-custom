---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

-- more keybinds!

M.buffer = {
  n = {
    ["<leader>tx"] = { "<cmd>:lua require('nvchad_ui.tabufline').closeAllBufs() <CR>", "Close All Bufs" },
  },
}

return M
