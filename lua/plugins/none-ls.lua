return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      local sources = opts.sources or {}
      opts.sources = vim.list_extend(sources, {
        nls.builtins.code_actions.gomodifytags,
        nls.builtins.code_actions.impl,
        nls.builtins.formatting.goimports,
        nls.builtins.formatting.gofumpt,
        nls.builtins.diagnostics.markdownlint,
        nls.builtins.diagnostics.codespell,
        nls.builtins.diagnostics.cfn_lint,
      })
    end,
  },
}
