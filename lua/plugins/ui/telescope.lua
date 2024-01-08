return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("file_browser")
    end,
    keys = {
      { "<leader>fd", "<cmd>Telescope file_browser<cr>", desc = "Browse Directory (root)" },
      {
        "<leader>fD",
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
        desc = "Browse Directory (cwd)",
      },
    },
  },
}
