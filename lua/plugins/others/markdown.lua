return {
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   enabled = true,
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  --   keys = {
  --     {
  --       "<leader>cp",
  --       ft = "markdown",
  --       "<cmd>MarkdownPreviewToggle<cr>",
  --       desc = "Markdown Preview",
  --     },
  --   },
  --   config = function()
  --     vim.cmd([[do FileType]])
  --   end,
  -- },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = false,
    config = function()
      require("render-markdown").setup({
        -- checkbox = {
        --   right_pad = 4,
        -- },
        --
        checkbox = {
          -- Turn on / off checkbox state rendering
          enabled = true,
          -- Determines how icons fill the available space:
          --  inline:  underlying text is concealed resulting in a left aligned icon
          --  overlay: result is left padded with spaces to hide any additional text
          -- position = "inline",
          -- unchecked = {
          --   -- Replaces '[ ]' of 'task_list_marker_unchecked'
          --   icon = "   󰄱 ",
          --   -- Highlight for the unchecked icon
          --   highlight = "RenderMarkdownUnchecked",
          --   -- Highlight for item associated with unchecked checkbox
          --   scope_highlight = nil,
          -- },
          checked = {
            -- Replaces '[x]' of 'task_list_marker_checked'
            icon = "   󰱒 ",
            -- Highlight for the checked icon
            highlight = "RenderMarkdownChecked",
            -- Highlight for item associated with checked checkbox
            scope_highlight = nil,
          },
        },
        heading = {
          sign = false,
          icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
          backgrounds = {
            "RenderMarkdownH1Bg",
            "RenderMarkdownH2Bg",
            "RenderMarkdownH3Bg",
            "RenderMarkdownH4Bg",
            "RenderMarkdownH5Bg",
            "RenderMarkdownH6Bg",
          },
          -- foregrounds = {
          --   "RenderMarkdownH1",
          --   "RenderMarkdownH2",
          --   "RenderMarkdownH3",
          --   "RenderMarkdownH4",
          --   "RenderMarkdownH5",
          --   "RenderMarkdownH6",
          -- },
        },
      })
      vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { fg = "#ffffff", bg = "#6b4f9a" })
      vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { fg = "#ffffff", bg = "#5c3f8a" })
      vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = "#ffffff", bg = "#4d3573" })
      vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { fg = "#ffffff", bg = "#3b5ea6" })
      vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { fg = "#ffffff", bg = "#2f4b7a" })
      vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { fg = "#ffffff", bg = "#263a5f" })
    end,
  },
}
