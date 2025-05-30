return {
  {
    "mfussenegger/nvim-dap",
    event = {},
    dependencies = {
      "rcarriga/nvim-dap-ui",
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      {
        "leoluz/nvim-dap-go",
        opts = {},
      },
      "fzf-lua",
    },
    config = function()
      local dap = require("dap")
      local ui = require("dapui")
      require("dapui").setup()
      require("dap-go").setup()

      -- Debugging Node was obviously an after thought
      local mason_registry = require("mason-registry")

      local node_debugger = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.expand("$MASON/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"),
            "${port}",
          },
        },
      }

      for _, type in ipairs({ "pwa-node", "node" }) do
        require("dap").adapters[type] = node_debugger
      end

      for _, language in ipairs({ "typescript", "javascript", "svelte", "astro" }) do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            skipFiles = {
              "${workspaceFolder}/node_modules/**/*.js",
              "${workspaceFolder}/packages/**/node_modules/**/*.js",
              "${workspaceFolder}/packages/**/**/node_modules/**/*.js",
              "<node_internals>/**",
              "node_modules/**",
            },
            sourceMaps = true,
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
          },
        }
      end

      require("nvim-dap-virtual-text").setup()

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
    keys = {
      { "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle Breakpoint" },
      { "<leader>dc", ":lua require'dap'.continue()<CR>", desc = "Start / Continue" },
      { "<leader>do", ":lua require'dap'.step_over()<CR>", desc = "Step Over" },
      { "<leader>d]", ":lua require'dap'.step_into()<CR>", desc = "Step Into" },
      { "<leader>d[", ":lua require'dap'.step_out()<CR>", desc = "Step Out" },
      { "<leader>dr", ":lua require'dap'.run_to_cursor<CR>", desc = "Run to Cursor" },
      { "<leader>du", ":lua require'dapui'.toggle({})<CR>", desc = "UI Toggle" },
      { "<leader>dl", ":lua require'dap.ext.vscode'.load_launchjs()<CR>", desc = "Load Launch.json" },
    },
  },
}
