return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
    {
      "Davidyz/VectorCode", -- Index and search code in your repositories
      version = "*",
      build = "pipx upgrade vectorcode",
      dependencies = { "nvim-lua/plenary.nvim" },
      cmd = "VectorCode",
    },
    {
      "echasnovski/mini.diff", -- Inline and better diff over the default
      config = function()
        local diff = require("mini.diff")
        diff.setup({
          -- Disabled by default
          source = diff.gen_source.none(),
        })
      end,
    },
  },
  opts = {
    opts = {
      language = "English",
      log_level = "TRACE",
    },
    extensions = {
      vectorcode = {
        enabled = true,
        opts = {
          add_tool = true,
        },
      },
      history = {
        enabled = true,
        opts = {
          auto_generate_title = false,
          continue_last_chat = false,
          picker = "fzf-lua",
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
        },
      },
    },
    adapters = {
      http = {
        opts = {
          show_presets = true,
        },
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "cluade-4.6-sonnet",
                -- default = "gpt-4.1",
              },
            },
          })
        end,
      },
    },
    interactions = {
      chat = {},
      inline = {},
      cmd = {},
    },
    display = {
      action_palette = {
        provider = "fzf_lua",
      },
      diff = {
        provider = "mini_diff",
      },
    },
  },
}
