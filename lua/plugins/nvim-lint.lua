local root_pattern = function() end

local insert_package_json = function() end

local file_pattern = function() end

local show_info = function() end

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      json = { "cfn_lint" },
      yaml = { "cfn_lint" },
      markdown = { "markdownlint" },
      ["*"] = { "cspell" },
    },
    linters = {
      cfn_lint = {
        condition = function(ctx)
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

          -- matches the word AWSTemplateFormatVersion optionally surrounded by quotes, zero to many spaces, followed by a colon
          local template_format_version_pattern = '%s*"?AWSTemplateFormatVersion"?%s*:'

          -- matches the word Resources optionally surrounded by quotes, zero to many spaces, followed by a colon
          local resources_pattern = '"?Resources"?%s*:'

          -- This pattern matches the naming convention of an AWS cloudformation resource type "Type": "AWS::ProductIdentifier::ResourceType"
          -- matches the word Type optionally surrounded by quotes, zero to many spaces, followed by a colon,
          -- followed by AWS, 2 colons, 1 or more alphanumeric characters for the product identifier, separated by 2 colons,
          -- followed by one or more alaphanumeric characters for the resource type.
          local resource_type_pattern = '"?Type"?%s*:%s*"?\'?AWS::%w+::%w+"?\'?'

          local found_resources = false
          for _, line in ipairs(lines) do
            if line:match(template_format_version_pattern) then
              return true
            end

            if line:match(resources_pattern) then
              found_resources = true
            end

            -- file must contain both Resources as well as Type key which matches the aws resource type naming convention
            if found_resources and line:match(resource_type_pattern) then
              return true
            end
          end

          return false
        end,
      },
      cspell = {},
      markdownlint = {},
    },
  },
  config = function(_, opts)
    local M = {}
    local lint = require("lint")

    lint.linters_by_ft = opts.linters_by_ft
    function M.lint()
      local names = lint._resolve_linter_by_ft(vim.bo.filetype)

      vim.list_extend(names, lint.linters_by_ft["*"] or {})

      for name, linter in pairs(opts.linters) do
        if type(linter) == "table" and type(lint.linters[name]) == "table" then
          lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
          if type(linter.prepend_args) == "table" then
            lint.linters[name].args = lint.linters[name].args or {}
            vim.list_extend(lint.linters[name].args, linter.prepend_args)
          end
        else
          lint.linters[name] = linter
        end
      end

      local ctx = { filename = vim.api.nvim_buf_get_name(0) }
      ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
      names = vim.tbl_filter(function(name)
        local linter = lint.linters[name]
        if not linter then
          return false
        end
        return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
      end, names)

      -- Run linters.
      if #names > 0 then
        lint.try_lint(names)
      end
    end

    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = M.lint,
    })

    vim.api.nvim_create_user_command("LintInfo", show_info, { desc = "Show nvim-lint info" })
  end,
}
