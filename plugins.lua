local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }

  -- custom

  -- override
  {
    "NvChad/nvterm",
    opts = overrides.nvterm,
  },

  {
    "hrsh7th/nvim-cmp",
    event = { "CmdlineEnter", "InsertEnter" },
    dependencies = {
      "hrsh7th/cmp-cmdline",
    },
    config = function(_, opts)
      require "custom.configs.cmp"
      require("cmp").setup(opts)
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },

  {
    "numToStr/Comment.nvim",
    config = function(_, opts)
      require("Comment").setup(vim.tbl_deep_extend("force", opts, {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }))
    end,
  },

  -- new
  {
    "Pocco81/TrueZen.nvim",
    cmd = { "TZNarrow", "TZFocus", "TZMinimalist", "TZAtaraxis" },
  },

  {
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
    config = function()
      require("spectre").setup {
        default = {
          replace = {
            cmd = "oxi",
          },
        },
      }
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    event = "BufRead",
    ft = { "rust" },
    config = function()
      require "custom.configs.rust-tools"
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    event = "BufRead",
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_theme = "dark"
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    ft = { "typescriptreact", "javascriptreact" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewFileHistory", "DiffviewOpen" },
    config = function()
      require("diffview").setup()
    end,
  },

  {
    "ziontee113/icon-picker.nvim",
    cmd = { "IconPickerNormal" },
    dependencies = {
      {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
      },
    },
    config = function()
      require("icon-picker").setup {
        disable_legacy_commands = true,
      }
    end,
  },

  {
    "antosha417/nvim-lsp-file-operations",
    event = "InsertEnter",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-tree.lua" },
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },

  {
    "rest-nvim/rest.nvim",
    event = "BufRead",
    ft = { "http" },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "chrishrb/gx.nvim",
    keys = { "gx" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true, -- default settings
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}

return plugins
