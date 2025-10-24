return {
  --   {
  --     "stevearc/conform.nvim",
  --     opts = {
  --       formatters_by_ft = {
  --         groovy = { "npm_groovy_lint" }, -- Use npm_groovy_lint for Groovy files
  --       },
  --       -- Optional: Configure formatting on save
  --       format_on_save = {
  --         lsp_fallback = true, -- Fallback to LSP if no conform formatter found
  --         async = false, -- Set to true for asynchronous formatting
  --         timeout_ms = 1000,
  --       },
  --     },
  --   },
}
