-- return {
--   "olimorris/codecompanion.nvim",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-treesitter/nvim-treesitter",
--   },
--   config = {
--     strategies = {
--       chat = {
--         adapter = "gemini",
--         keymaps = {
--           close = {
--             modes = { n = "<C-F14>", i = "<C-F14>" },
--           },
--         },
--       },
--       inline = {
--         adapter = "gemini",
--       },
--     },
--   },
--   keys = {
--     { "<C-a>", "<CMD>CodeCompanionActions<CR>", silent = true, mode = { "n" }, desc = "CodeCompanionActions" },
--   },
-- }

return {
  {
    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      instructions_file = "avante.md",
      provider = "gemini-cli",
      -- provider = "copilot",
      -- auto_suggestions_provider = "copilot",
      -- acp_providers = {
      --   ["gemini-cli"] = {
      --     command = "gemini",
      --     args = { "--experimental-acp" },
      --     -- args = { "--experimental-acp -m gemini-2.5-flash" },
      --   },
      -- },
      behaviour = {
        auto_focus_sidebar = false,
        -- auto_approve_tool_permissions = false,
        enable_fastapply = false,
      },
      input = {
        provider = "snacks",
        provider_opts = {
          -- Additional snacks.input options
          title = "Avante Input",
          icon = " ",
        },
      },
      selector = {
        -- @alias avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
        -- @type avante.SelectorProvider
        provider = "fzf_lua",
        -- Options override for custom providers
        provider_opts = {},
      },
      windows = {
        width = 40,
        fillchars = "eob: ,horiz:─,horizdown:┬,horizup:┴,vert:│,verthoriz:┼,vertleft:┤,vertright:├",
        input = {
          prefix = "❯",
          height = 12,
        },
        edit = {
          border = "rounded",
          start_insert = false,
        },
        ask = {
          -- floating = true,
          border = "double",
          start_insert = false,
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-mini/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or nvim-mini/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      -- {
      --   -- support for image pasting
      --   "HakonHarnes/img-clip.nvim",
      --   event = "VeryLazy",
      --   opts = {
      --     -- recommended settings
      --     default = {
      --       embed_image_as_base64 = false,
      --       prompt_for_file_name = false,
      --       drag_and_drop = {
      --         insert_mode = true,
      --       },
      --       -- required for Windows users
      --       use_absolute_path = true,
      --     },
      --   },
      -- },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "folke/sidekick.nvim",
    enabled = false,
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<c-.>",
        function()
          require("sidekick.cli").focus()
        end,
        mode = { "n", "x", "i", "t" },
        desc = "Sidekick Switch Focus",
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle({ name = "gemini", focus = true })
        end,
        desc = "Sidekick Toggle CLI",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").select_prompt()
        end,
        desc = "Sidekick Ask Prompt",
        mode = { "n", "v" },
      },
    },
  },
}
