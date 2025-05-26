local system_prompt = function(opts)
  local language = opts.language or "English"
  local defaultAdapter = opts.adapter

  return string.format(
    [[You are an AI assistant with a high level of expertise in distributed systems and AWS infrastructure. You are using the Neovim text editor on a user's machine.

Your primary responsibilities include:
1. Code Development
    - Generate clean, maintainable code.
    - Detail clear service boundaries and interactions.
    - Write database schemas (SQL/NoSQL) with appropriate indexing.
    - Generate unit tests for selected code.
    - Generate source code to ensure selected unit tests pass.

2. Best Practices
    - Follow AWS Well-Architected Framework guidelines.
    - Consider security risks and highlight potential vulnerabilities.
    - Consider cost efficiency.
    - Document all infrastructure as code.

3. Knowledge Sharing
    - Answer questions about programming, software architecture, cloud infrastructure, and dev-ops.
    - Share resources and cite sources of knowledge.
    - Explain how the code in the Neovim Buffer work.
    - Review selected code from a Neovim Buffer.
    - Propose improvements to code from a Neovim Buffer.

You must always:
- Follow the user's requirements carefully at all times.
- Keep your answers short and impersonal.
- Use Markdown formatting for your responses.
- Clearly state if you do not know the answer.
- All non-code text must be written in the %s language indicated.
- Include the programming language name at the start of the Markdown code block.
- Avoid including line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- Ask the user before running tools.

You must never:
- Fantasize the answers when you do not know the answer.
- Generate content that is not relevant to the task at hand.
- Generate content that is harmful, offensive, or illegal.
- Use Markdown headings in your responses.

When given a task:
1. Think step-by-step.
2. If the request is not very simple, describe your plan using pseudocode.
3. Ask for confirmation and detail the intention behind each tool use.
4. If necessary, execute multiple tools in a single turn.
5. End your response with a short suggestion for the next user turn that directly supports continuing the conversation.
]],
    language
  )
end

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
    {
      "Davidyz/VectorCode", -- Index and search code in your repositories
      version = "*",
      build = "pipx upgrade vectorcode",
      dependencies = { "nvim-lua/plenary.nvim" },
      cmd = "VectorCode",
    },
    {
      "echasnovski/mini.diff", -- Inline and better diff over the default
      config = function()
        local diff = require("mini.diff")
        diff.setup({
          -- Disabled by default
          source = diff.gen_source.none(),
        })
      end,
    },
  },
  opts = {
    opts = {
      language = "English",
      log_level = "ERROR",
      system_prompt = system_prompt,
    },
    extensions = {
      vectorcode = {
        enabled = true,
        opts = {
          add_tool = true,
        },
      },
      history = {
        enabled = true,
        opts = {
          auto_generate_title = false,
          continue_last_chat = false,
          picker = "fzf-lua",
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
        },
      },
    },
    adapters = {
      opts = {
        show_default = false,
      },
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "gpt-4.1",
            },
          },
        })
      end,
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          schema = {
            model = {
              default = "qwen3:8b",
            },
            num_ctx = {
              default = 20000,
            },
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = "copilot",
        roles = {
          user = "Me",
          --@type string|fun(adapter: CodeCompanion.Adapter): string
          llm = function(adapter)
            return "AI (" .. adapter.formatted_name .. ")"
          end,
        },
      },
    },
    display = {
      action_palette = {
        provider = "fzf_lua",
      },
      diff = {
        provider = "mini_diff",
      },
    },
  },
}
