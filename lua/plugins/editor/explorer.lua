return {
  {
    "echasnovski/mini.files",
    -- enabled = false,
    opts = {
      windows = {
        preview = true,
        width_nofocus = 20,
        width_focus = 40,
        width_preview = 40,
      },
      options = {
        use_as_default_explorer = false,
      },
      content = {
        prefix = nil,
      },
      mappings = {
        go_in = "",
        go_in_plus = "<CR>",
        go_out = "",
        go_out_plus = "<BS>",
        reset = "-",
      },
    },
    keys = {
      {
        "<leader>fm",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
          require("mini.files").reveal_cwd()
        end,
        desc = "Open mini.files (directory of current file)",
      },
      {
        "<leader>fM",
        function()
          require("mini.files").open(vim.loop.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)

      local show_dotfiles = true
      local filter_show = function(fs_entry)
        return true
      end
      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".")
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require("mini.files").refresh({ content = { filter = new_filter } })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak left-hand side of mapping to your liking
          vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          require("lazyvim.util").lsp.on_rename(event.data.from, event.data.to)
        end,
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    enabled = false,
    opts = {
      keymaps = {
        ["<BS>"] = "actions.parent",
      },
    },
    keys = {
      { "<leader>fm", "<CMD>Oil --float<CR>", mode = { "n" }, silent = true, desc = "Open parent directory" },
    },
  },
}
