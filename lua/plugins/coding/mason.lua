return {

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
      },
      automatic_installation = true,
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "○",
          package_uninstalled = "✗",
        },
      },
    },
  },
}
