return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        mode = { "n", "v" },
        { "<leader>d", group = "Debug" },
        { "<leader>f", group = "Files" },
        { "<leader>fg", group = "Git" },
        { "<leader>c", group = "Code" },
        { "<leader>g", group = "Go To..." },
        { "<leader><tab>", group = "Tabs" },
        { "<leader>t", group = "Test" },
        {
          "<leader>b",
          group = "Buffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        {
          "<leader>w",
          group = "Windows",
          proxy = "<c-w>",
          expand = function()
            return require("which-key.extras").expand.win()
          end,
        },
      },
    },
  },
}
