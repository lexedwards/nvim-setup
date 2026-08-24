return {
  {
    "lexedwards/themectl.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require("themectl").setup(opts)
      vim.cmd.colorscheme("themectl")
    end,
  },
}
