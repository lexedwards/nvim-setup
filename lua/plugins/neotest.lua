return {
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
      "rouge8/neotest-rust",
    },
    opts = {
      adapters = {
        ["neotest-go"] = {},
        ["neotest-rust"] = {
          dap_adapter = "lldb",
        },
      },
    },
  },
}
