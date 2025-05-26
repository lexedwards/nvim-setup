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
      servers = {
        astro = {},
        biome = {},
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
        ts_ls = {
          server_capabilities = {
            documentFormattingProvider = false,
          },
          settings = {
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              },
            },

            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              },
            },
          },
        },
        yamlls = {
          yaml = {
            schemaStore = {
              enable = true,
            },
            hover = true,
            completion = true,
            customTags = {
              "!fn",
              "!And",
              "!If",
              "!Not",
              "!Equals",
              "!Or",
              "!FindInMap sequence",
              "!Base64",
              "!Cidr",
              "!Ref",
              "!Ref Scalar",
              "!Sub",
              "!GetAtt",
              "!GetAZs",
              "!ImportValue",
              "!Select",
              "!Split",
              "!Join sequence",
            },
          },
        },
      },
    },
    config = function(_, opts)
      -- local lspconfig = require("lspconfig")

      for server, serverOpts in pairs(opts.servers) do
        vim.lsp.config(server, serverOpts)
        -- lspconfig[server].setup(serverOpts)
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "LspSupportsMethod",
        callback = function(args)
          local buffer = args.data.buffer ---@type number
          if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == "" then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          end
        end,
      })

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
          vim.keymap.set("n", "<leader>ch", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
          end, { desc = "Enable/Disable Inline Hints" })
        end,
      })
    end,
  },
}
