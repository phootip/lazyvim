-- NOTE: render images inline in terminal (kitty/wezterm/ghostty graphics protocol)
---@diagnostic disable: undefined-global
return {
  {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      processor = "magick_cli",
      tmux_show_only_in_active_window = true,
      hijack_file_patterns = {},
      window_overlap_clear_enabled = true,
      -- window_overlap_clear_ft_ignore = {
      --   "cmp_menu",
      --   "cmp_docs",
      --   "snacks_notif",
      --   "scrollview",
      --   "scrollview_sign",
      --   "minifiles",
      --   "minifiles-help",
      -- },
      editor_only_render_when_focused = true,
    },
  },
  -- NOTE: paste images from clipboard, save to disk, insert markdown link
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      default = {
        dir_path = function()
          if vim.fn.fnamemodify(vim.fn.getcwd(), ":t") == "notes" then
            return "Statics/Attachments"
          end
          return "assets"
        end,
      },
    },
    keys = {
      -- suggested keymap
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
      { "<leader>ip", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
      {
        "<leader>id",
        function()
          local line = vim.api.nvim_get_current_line()
          local path = line:match("!%[[^%]]*%]%(([^)]+)%)")
          if not path then
            vim.notify("No image link on current line", vim.log.levels.WARN)
            return
          end
          local abs = vim.fn.fnamemodify(path, ":p")
          if vim.fn.filereadable(abs) == 0 then
            abs = vim.fn.getcwd() .. "/" .. path
          end
          local choice = vim.fn.confirm("Delete image file?\n" .. abs, "&Yes\n&No", 2)
          if choice ~= 1 then
            return
          end
          local ok, err = os.remove(abs)
          if not ok then
            vim.notify("Failed: " .. tostring(err), vim.log.levels.ERROR)
            return
          end
          local new_line = line:gsub("!%[[^%]]*%]%([^)]+%)", "", 1)
          if new_line:match("^%s*$") then
            vim.api.nvim_buf_set_lines(0, vim.fn.line(".") - 1, vim.fn.line("."), false, {})
          else
            vim.api.nvim_set_current_line(new_line)
          end
          vim.notify("Deleted: " .. abs)
        end,
        desc = "Delete image file + link on current line",
      },
      {
        "<leader>it",
        function()
          local api = require("image")
          if api.is_enabled() then
            api.disable()
            vim.notify("image.nvim: disabled")
          else
            api.enable()
            vim.notify("image.nvim: enabled")
          end
        end,
        desc = "Toggle image rendering",
      },
    },
  },
}
