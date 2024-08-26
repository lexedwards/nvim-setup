return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      {
        "b0o/SchemaStore.nvim",
        lazy = true,
        version = false,
      },
      {
        "ibhagwan/fzf-lua",
      },
    },
    opts = {
      inlay_hints = {
        enabled = true,
      },
      servers = {
        astro = {},
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
          },
        },
        gopls = {
          gofumpt = true,
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
        jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
        lua_ls = {},
        marksman = {},
        mdx_analyzer = {},
        svelte = {},
        taplo = {},
        tsserver = {
          server_capabilities = {
            documentFormattingProvider = false,
          },
        },
        yamlls = {},
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")

      for server, serverOpts in pairs(opts.servers) do
        lspconfig[server].setup(serverOpts)
      end

      vim.api.nvim_create_autocmd("LspAttach", {

        callback = function()
          local fzf = require("fzf-lua")

          vim.keymap.set("n", "gd", fzf.lsp_definitions, { desc = "Definition" })
          vim.keymap.set("n", "gr", fzf.lsp_references, { desc = "References", nowait = true })
          vim.keymap.set("n", "gi", fzf.lsp_implementations, { desc = "Implementation" })
          vim.keymap.set("n", "gt", fzf.lsp_typedefs, { desc = "Type Definition" })
          vim.keymap.set("n", "gD", fzf.lsp_declarations, { desc = "Declaration" })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })

          -- Code Actions
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
          vim.keymap.set("n", "<leader>ca", fzf.lsp_code_actions, { desc = "Action" })
          vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostic" })
        end,
      })
    end,
  },
}
