return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
    opts = {
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"}
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("fzf")
    end,
    keys = {
      -- { "<leader>fd", "<cmd>telescope file_browser<cr>", desc = "browse directory (root)" },
      -- { "<leader>ff", "<cmd>telescope find_files<cr>", desc = "find file (root)" },
      -- { "<leader>fgf", "<cmd>telescope git_files<cr>", desc = "find files (git-files)" },
      -- { "<leader>fr", "<cmd>telescope oldfiles<cr>", desc = "recent" },
      -- { "<leader>fgc", "<cmd>telescope git_commits<cr>", desc = "git commits" },
      -- { "<leader>fgs", "<cmd>telescope git_status<cr>", desc = "git status" },
      -- { "<leader>ft", "<cmd>telescope live_grep<cr>", desc = "text (grep)" },
    },
  },
}
