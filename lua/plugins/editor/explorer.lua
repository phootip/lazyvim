local show_gitignore = true

local projects = {
  lazyvim = {
    dir = "/Users/phootip.t.extbankx.live/.config/lazyvim",
    allowed = { ["lua"] = true, ["init.lua"] = true },
  },
}

local project = projects[vim.g.project]
local target_dir = project and vim.fn.fnamemodify(project.dir, ":p"):gsub("/$", "") or ""
local allowed = project and project.allowed or {}

if project and vim.g.mini_files_focus == nil then
  vim.g.mini_files_focus = true
end

local focus_filter = function(entry)
  local parent = vim.fn.fnamemodify(entry.path, ":h")
  if parent == target_dir then
    return allowed[entry.name] == true
  end
  return true
end
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

local toggle_filter = function()
  vim.g.mini_files_focus = not vim.g.mini_files_focus
  require("mini.files").refresh({ content = { filter = require("mini.files").config.content.filter } })
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
    "nvim-mini/mini.files",
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
        prefix = function(entry)
          local icon, hl = require("mini.files").default_prefix(entry)
          if not vim.g.mini_files_focus then
            local parent = vim.fn.fnamemodify(entry.path, ":h")
            if parent == target_dir and allowed[entry.name] then
              return icon .. "** ", hl
            end
          end
          return icon, hl
        end,
        filter = function(entry)
          if vim.g.mini_files_focus then
            return focus_filter(entry)
          end
          return true
        end,
      },
      mappings = {
        go_in = "",
        go_in_plus = "l",
        go_out = "",
        go_out_plus = "h",
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
          vim.keymap.set("n", "gf", toggle_filter, { buffer = buf_id })
          vim.keymap.set("n", "ga", function()
            local entry = require("mini.files").get_fs_entry()
            if entry then
              allowed[entry.name] = not allowed[entry.name] or nil
              require("mini.files").refresh({ content = { filter = require("mini.files").config.content.filter } })
            end
          end, { buffer = buf_id })
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
}
