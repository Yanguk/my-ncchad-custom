local util = require "custom.configs.util"
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
    ["<leader>tx"] = {
      "<cmd>:lua require('nvchad_ui.tabufline').closeAllBufs() <CR>",
      "Close all bufs",
      { nowait = true },
    },
  },
}

M.spectre = {
  n = {
    ["<leader>S"] = {
      '<cmd>lua require("spectre").open()<CR>',
      "Open Spectre",
      { nowait = true },
    },
    ["<leader>sw"] = {
      '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
      "Search current word",
      { nowait = true },
    },
    ["<leader>sp"] = {
      '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
      "Search on current file",
      { nowait = true },
    },
  },
  v = {
    ["<leader>sw"] = {
      '<esc><cmd>lua require("spectre").open_visual()<CR>',
      "Search current word",
      { nowait = true },
    },
  },
}

M.markdown_preview = {
  n = {
    ["<leader>mp"] = { "<cmd> MarkdownPreview<CR>", "Open preview", { nowait = true } },
    ["<leader>mc"] = { "<cmd> MarkdownPreviewStop<CR>", "Close preview", { nowait = true } },
  },
}

M.trailing_space = {
  n = {
    ["<leader>ts"] = { util.toggle_trailing_space, "Toggle trailing space", { nowait = true } },
  },
}

M.diff_view = {
  n = {
    ["<leader>dv"] = { ":DiffviewFileHistory %<CR>", "Diffview file %", { nowait = true } },
    ["<leader>dc"] = { ":DiffviewClose<CR>", "Diffview close", { nowait = true } },
  },
}

return M
