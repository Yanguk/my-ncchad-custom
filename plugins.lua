-- cSpell:disable
local overrides = require "custom.configs.overrides"

local WEB_FT_LIST = {
  "html",
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "svelte",
  "vue",
  "tsx",
  "jsx",
  "rescript",
  "xml",
  "php",
  "markdown",
  "astro",
  "glimmer",
  "handlebars",
  "hbs",
}

---@type NvPluginSpec[]
local plugins = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "nvimtools/none-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
        dependencies = {
          "davidmh/cspell.nvim",
        },
      },
      {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
  },

  {
    "NvChad/nvterm",
    opts = overrides.nvterm,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "hrsh7th/cmp-cmdline",
        event = { "CmdLineEnter" },
        opts = {
          history = true,
          updateevents = "CmdlineEnter,CmdlineChanged",
        },
        config = function()
          local cmp = require "cmp"

          cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
              { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
            }, {
              { name = "buffer" },
            }),
          })

          cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = "buffer" },
            },
          })

          -- `:` cmdline setup.
          cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
              { name = "path" },
            }, {
              {
                name = "cmdline",
                option = {
                  ignore_cmds = { "Man", "!" },
                },
              },
            }),
          })
        end,
      },
      {
        "zbirenbaum/copilot-cmp",
      },
    },
    config = function(_, opts)
      local cmp = require "cmp"

      opts.preselect = cmp.PreselectMode.None

      opts.mapping["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }

      opts.completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      }

      cmp.setup(opts)
    end,
    opts = overrides.cmp,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },

  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gcc" },
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    ft = WEB_FT_LIST,
    dependencies = { "numToStr/Comment.nvim" },
    config = function(_, opts)
      require("Comment").setup(vim.tbl_deep_extend("force", opts, {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }))
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
  },

  {
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
  },

  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
      vim.g.mkdp_theme = "dark"
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = WEB_FT_LIST,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewFileHistory", "DiffviewOpen" },
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
  },

  {
    "rest-nvim/rest.nvim",
    ft = { "http" },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require "statuscol.builtin"
          require("statuscol").setup {
            relculright = true,
            segments = {
              { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
              { text = { "%s" },                  click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          }
        end,
      },
    },
    config = function(_, opts)
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "open All Folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "close All Folds" })

      require("ufo").setup(opts)
    end,
  },

  {
    "kylechui/nvim-surround",
    keys = { "ys", "ds", "cs" },
    version = "*",
  },

  {
    "andrewferrier/debugprint.nvim",
    opts = overrides.debugprint,
    keys = { "g?" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function(_, opts)
      require("debugprint").setup(opts)

      vim.keymap.set("n", "g?d", require("debugprint").deleteprints, { desc = "DeleteDebugPrints" })
    end,
    version = "*",
  },

  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = { stages = "static" },
    config = function(_, opts)
      require("notify").setup(opts)
      vim.notify = require "notify"
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = overrides.copilot,
  },

  {
    "ggandor/leap.nvim",
    keys = { "s", "S", desc = "Leap" },
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  {
    "lbrayner/vim-rzip",
    ft = { "zip" },
  },

  {
    "cameron-wags/rainbow_csv.nvim",
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
  },

  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup { enable_builtin = true }
      vim.cmd [[hi OctoEditable guibg=none]]
    end,
    keys = {
      { "<leader>O", "<cmd>Octo<cr>", desc = "Octo" },
    },
  },

  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      local crates = require "crates"
      crates.setup()

      vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, {
        silent = true,
        desc = "Show Crates Versions",
      })

      vim.keymap.set("n", "<leader>cf", crates.show_features_popup, {
        silent = true,
        desc = "Show Crates Features",
      })

      vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, {
        silent = true,
        desc = "Show Crates Dependencies",
      })
    end,
  },
}

return plugins
