-- stylua: ignore
return {
  {
    "otavioschwanck/arrow.nvim",
    dependencies = {
      { "nvim-mini/mini.icons" },
    },
    event = "VeryLazy",
    opts = {
      show_icons = true,
      leader_key = ';', -- Recommended to be a single key
      buffer_leader_key = 'm', -- Per Buffer Mappings
    },
    keys = {
      -- { "<M-h>", function() require("arrow.persist").go_to(1) end },
      -- { "<M-j>", function() require("arrow.persist").go_to(2) end },
      -- { "<M-k>", function() require("arrow.persist").go_to(3) end },
      -- { "<M-l>", function() require("arrow.persist").go_to(4) end },
    }
  },
  {
    "TheNoeTrevino/haunt.nvim",
    -- default config: change to your liking, or remove it to use defaults
    ---@class HauntConfig
    opts = {
      sign = "󱙝",
      sign_hl = "DiagnosticInfo",
      virt_text_hl = "HauntAnnotation",
      annotation_prefix = " 󰆉 ",
      line_hl = nil,
      virt_text_pos = "eol",
      data_dir = nil,
      picker_keys = {
        delete = { key = "d", mode = { "n" } },
        edit_annotation = { key = "a", mode = { "n" } },
      },
    },
    -- recommended keymaps, with a helpful prefix alias
    init = function()
      local haunt = require("haunt.api")
      local haunt_picker = require("haunt.picker")
      local map = vim.keymap.set
      local prefix = "<leader>h"

      map("n", prefix .. "<space>", function()
        require("which-key").show({
          keys = prefix,
          loop = true,
        })
      end)

      -- annotations
      map("n", prefix .. "a", function()
        haunt.annotate()
      end, { desc = "Annotate" })

      map("n", prefix .. "t", function()
        haunt.toggle_annotation()
      end, { desc = "Toggle annotation" })

      map("n", prefix .. "T", function()
        haunt.toggle_all_lines()
      end, { desc = "Toggle all annotations" })

      map("n", prefix .. "d", function()
        haunt.delete()
      end, { desc = "Delete bookmark" })

      map("n", prefix .. "C", function()
        haunt.clear_all()
      end, { desc = "Delete all bookmarks" })

      -- move
      map("n", prefix .. "k", function()
        haunt.prev()
      end, { desc = "Previous bookmark"})

      map("n", prefix .. "j", function()
        haunt.next()
      end, { desc = "Next bookmark"})


      -- picker
      map("n", prefix .. "l", function()
        haunt_picker.show()
      end, { desc = "Show Picker" })

      -- quickfix 
      map("n", prefix .. "q", function()
        haunt.to_quickfix()
      end, { desc = "Send Hauntings to QF Lix (buffer)" })

      map("n", prefix .. "Q", function()
        haunt.to_quickfix({ current_buffer = true })
      end, { desc = "Send Hauntings to QF Lix (all)" })

      -- yank
      map("n", prefix .. "y", function()
        haunt.yank_locations({current_buffer = true})
      end, { desc = "Send Hauntings to Clipboard (buffer)" })

      map("n", prefix .. "Y", function()
        haunt.yank_locations()
      end, { desc = "Send Hauntings to Clipboard (all)" })

    end,
  }
}
