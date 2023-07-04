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
    },
  },
}

M.spectre = {
  n = {
    ["<leader>S"] = {
      '<cmd>lua require("spectre").open()<CR>',
      "Open Spectre",
    },
    ["<leader>sw"] = {
      '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
      "Search current word",
    },
    ["<leader>sp"] = {
      '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
      "Search on current file",
    },
  },
  v = {
    ["<leader>sw"] = {
      '<esc><cmd>lua require("spectre").open_visual()<CR>',
      "Search current word",
    },
  },
}

M.markdown_preview = {
  n = {
    ["<leader>mp"] = { "<cmd> MarkdownPreview<CR>", "Open preview",  },
    ["<leader>mc"] = { "<cmd> MarkdownPreviewStop<CR>", "Close preview",  },
  },
}

M.trailing_space = {
  n = {
    ["<leader>ts"] = { util.toggle_trailing_space, "Toggle trailing space",  },
  },
}

M.diff_view = {
  n = {
    ["<leader>dv"] = { ":DiffviewFileHistory %<CR>", "Diffview file %",  },
    ["<leader>dc"] = { ":DiffviewClose<CR>", "Diffview close",  },
  },
}

M.icon_picker = {
  n = {
    ["<leader>ip"] = { "<cmd>IconPickerNormal<CR>", "Open icon picker",  },
  },
}

M.true_zen = {
  n = {
    ["<leader>zn"] = { ":TZNarrow<CR>", "TZNarrow",  },
    ["<leader>zf"] = { ":TZFocus<CR>", "TZFocuse",  },
    ["<leader>zm"] = { ":TZMinimalist<CR>", "TZMinimallist",  },
    ["<leader>za"] = { ":TZAtaraxis<CR>", "TZAtaraxis",  },
  },
  v = {
    ["<leader>zn"] = { ":'<,'>TZNarrow<CR>", "TZNarrow",  },
  },
}

M.gitsigns = {
	n = {
		["<leader>gl"] = { ":Gitsigns toggle_current_line_blame<CR>", "Toggle line blame" }
	}
}

return M
