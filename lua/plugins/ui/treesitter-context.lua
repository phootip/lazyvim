return {
  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  --   config = function()
  --     vim.cmd("hi TreesitterContextBottom gui=underline guisp=Grey")
  --     vim.cmd("hi link TreesitterContext LspReferenceText")
  --   end,
  -- },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     ensure_installed = {
  --       "hcl",
  --       "terraform",
  --     },
  --   },
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "groovy" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        groovyls = {},
      },
    },
  },
  -- {
  --   "mfussenegger/nvim-lint",
  --   optional = true,
  --   opts = {
  --     linters_by_ft = {
  --       groovy = { "npm-groovy-lint" },
  --     },
  --     linters = {
  --       ["npm-groovy-lint"] = {
  --         args = { "--failon", "error" },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "stevearc/conform.nvim",
  --   optional = true,
  --   opts = {
  --     formatters_by_ft = {
  --       groovy = { "npm_groovy_lint" },
  --     },
  --     formatters = {
  --       npm_groovy_lint = {
  --         command = "npm-groovy-lint",
  --         args = { "--failon", "error", "--format", "$FILENAME" },
  --         cwd = require("conform.util").root_file({ ".git" }),
  --         stdin = false,
  --       },
  --     },
  --   },
  -- },
}
