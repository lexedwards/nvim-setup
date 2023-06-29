return {
  { import = "lazyvim.plugins.extras.lang.typescript" },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
    },
    keys = {
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run last test",
      },
      {
        "<leader>tdl",
        function()
          require("neotest").run.run_last({ strategy = "dap" })
        end,
        desc = "Debug last test",
      },
      {
        "<leader>tw",
        "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
        desc = "Run ( Watch )",
      },
    },
    opts = {
      ["neotest-jest"] = {
        jestCommand = "pnpm test --",
      },
      ["neotest-vitest"] = {},
    },
  },
}
