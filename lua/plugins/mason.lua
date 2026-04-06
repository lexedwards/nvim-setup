return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    opts = {
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
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = false,
      ensure_installed = {
        "astro",
        "biome",
        "eslint",
        "gopls",
        "jsonls",
        "lua_ls",
        "marksman",
        "svelte",
        "terraformls",
        "ts_ls",
      },
    },
    dependencies = {
      "williamboman/mason.nvim",
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "delve",
        "codelldb",
        "js",
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = {
      ensure_installed = {
        -- "cfn-lint",
        -- "codespell",
        "cspell",
        "goimports",
        "gofumpt",
        "gomodifytags",
        "markdownlint-cli2",
        "prettier",
        "stylua",
        "tflint",
      },
    },
  },
}
