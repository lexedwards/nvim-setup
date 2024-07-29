return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    -- build = "./install --bin",
    config = function(_, opts)
      -- calling `setup` is optional for customization
      require("fzf-lua").setup(opts)
    end,
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "find file (root)" },
      { "<leader>fgf", "<cmd>FzfLua git_files<cr>", desc = "find files (git-files)" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "recent" },
      { "<leader>fgc", "<cmd>FzfLua git_commits<cr>", desc = "git commits" },
      { "<leader>fgs", "<cmd>FzfLua git_status<cr>", desc = "git status" },
      { "<leader>ft", "<cmd>FzfLua live_grep<cr>", desc = "text (grep)" },
    },
  },
}
