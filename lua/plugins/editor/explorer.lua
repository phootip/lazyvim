local show_gitignore = false
local sort_hide = function(entries)
  -- technically can filter entries here too, and checking gitignore for _every entry individually_
  -- like I would have to in `content.filter` above is too slow. Here we can give it _all_ the entries
  -- at once, which is much more performant.
  local all_paths = table.concat(
    vim
      .iter(entries)
      :map(function(entry)
        return entry.path
      end)
      :totable(),
    "\n"
  )
  local output_lines = {}
  local job_id = vim.fn.jobstart({ "git", "check-ignore", "--stdin" }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      output_lines = data
    end,
  })

  -- command failed to run
  if job_id < 1 then
    return entries
  end

  -- send paths via STDIN
  vim.fn.chansend(job_id, all_paths)
  vim.fn.chanclose(job_id, "stdin")
  vim.fn.jobwait({ job_id })
  return require("mini.files").default_sort(vim
    .iter(entries)
    :filter(function(entry)
      return not vim.tbl_contains(output_lines, entry.path)
    end)
    :totable())
end

local toggle_gitignore = function()
  show_gitignore = not show_gitignore
  if show_gitignore then
    require("mini.files").refresh({ content = { sort = require("mini.files").default_sort } })
  else
    require("mini.files").refresh({ content = { sort = sort_hide } })
  end
end
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
    config = function(_, opts)
      require("mini.files").setup(opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          vim.keymap.set("n", "gh", toggle_gitignore, { buffer = buf_id })
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          require("snacks").rename.on_rename_file(event.data.from, event.data.to)
        end,
      })
    end,
    keys = {
      {
        "<leader>fm",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)

          if show_gitignore then
            require("mini.files").refresh({ content = { sort = nil } })
          else
            require("mini.files").refresh({ content = { sort = sort_hide } })
          end
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
