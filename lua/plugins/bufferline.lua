return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {

      { "<leader><tab>l", "<cmd>tablast<cr>", desc = "Last Tab" },
      { "<leader><tab>f", "<cmd>tabfirst<cr>", desc = "First Tab" },
      { "<leader><tab>n", "<cmd>tabnew<cr>", desc = "New Tab" },
      { "<leader><tab>q", "<cmd>tabclose<cr>", desc = "Close Tab" },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
}
