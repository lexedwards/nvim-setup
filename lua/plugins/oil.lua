return {
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    config = function(_, opts)
      require("oil").setup(opts)
    end,
    keys = {
      { "<leader>fd", "<cmd>Oil<cr>", desc = "Browse folders" },
    },
  },
}
