return {
  {
    "neovim/nvim-lspconfig",
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "○",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    enabled = false,
  },
  {
    "folke/which-key.nvim",
    opts = {
      ["<leader>dw"] = { name = "+widgets" },
    },
  },
  {
    "mfussenegger/nvim-dap",
    keys = {},
  },
  { import = "lazyvim.plugins.extras.dap.nlua" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "plugins.custom.lang.rust" },
}
