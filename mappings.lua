local util = require "custom.configs.util"
---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

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
    ["<leader>mp"] = { "<cmd> MarkdownPreview<CR>", "Open preview" },
    ["<leader>mc"] = { "<cmd> MarkdownPreviewStop<CR>", "Close preview" },
  },
}

M.trailing_space = {
  n = {
    ["<leader>ts"] = { util.toggle_trailing_space, "Toggle trailing space" },
  },
}

M.diff_view = {
  n = {
    ["<leader>do"] = { ":DiffviewOpen<CR>", "Diffview open" },
    ["<leader>dv"] = { ":DiffviewFileHistory %<CR>", "Diffview file %" },
    ["<leader>dc"] = { ":DiffviewClose<CR>", "Diffview close" },
  },
}

M.icon_picker = {
  n = {
    ["<leader>ip"] = { "<cmd>IconPickerNormal emoji nerd_font<CR>", "Open icon picker" },
  },
}

M.zen_mode = {
  n = {
    ["<leader>zm"] = { ":ZenMode<CR>", "ZenMode" },
  },
}

M.gitsigns = {
  n = {
    ["<leader>gl"] = { ":Gitsigns toggle_current_line_blame<CR>", "Toggle line blame" },
  },
}

M.nvimtree = {
  n = {
    ["<leader>fr"] = { ":NvimTreeRefresh <CR>", "Refresh nvimtree" },
  },
}

M.rest_nvim = {
  n = {
    ["<leader>ru"] = { "<Plug>RestNvim", "Rest under cursor" },
    ["<leader>rp"] = { "<Plug>RestNvimPreview", "Rest preview" },
    ["<leader>rl"] = { "<Plug>RestNvimLast", "Rest last" },
  },
}

M.lazyGit = {
  n = {
    ["<leader>gg"] = { ":LazyGit <CR>", "Open lazyGit" },
  },
}

M.trouble = {
  n = {
    ["<leader>lo"] = {
      function()
        require("trouble").open()
      end,
      "Open Trouble",
    },
    ["<leader>lw"] = {
      function()
        require("trouble").open "workspace_diagnostics"
      end,
      "Open Workspace Diagnostics in Trouble",
    },
    ["<leader>ld"] = {
      function()
        require("trouble").open "document_diagnostics"
      end,
      "Open Document Diagnostics in Trouble",
    },
    ["<leader>ll"] = {
      function()
        require("trouble").open "quickfix"
      end,
      "Open Quickfix List in Trouble",
    },
    ["<leader>lq"] = {
      function()
        require("trouble").open "loclist"
      end,
      "Open Location List in Trouble",
    },
    ["<leader>lx"] = {
      function()
        require("trouble").close()
      end,
      "Close Trouble",
    },
    ["gR"] = {
      function()
        require("trouble").open "lsp_references"
      end,
      "Open LSP References in Trouble",
    },
  },
}

return M
