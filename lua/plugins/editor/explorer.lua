-- NOTE: creating project
-- nvim --cmd "let g:project='cluster'"
-- ~/.local/share/nvim/mini_files_focus/cluster.json

local show_gitignore = true

local target_dir = vim.g.project and vim.fn.fnamemodify(vim.fn.getcwd(), ":p"):gsub("/$", "") or ""
local allowed = {}

local persist_path = nil
if vim.g.project then
  local dir = vim.fn.stdpath("data") .. "/mini_files_focus"
  vim.fn.mkdir(dir, "p")
  persist_path = dir .. "/" .. vim.g.project .. ".json"
  local f = io.open(persist_path, "r")
  if f then
    local content = f:read("*a")
    f:close()
    local ok, data = pcall(vim.json.decode, content)
    if ok and type(data) == "table" then
      for k, v in pairs(data) do
        allowed[k] = v
      end
    end
  end
end

local save_allowed = function()
  if not persist_path then
    return
  end
  local f = io.open(persist_path, "w")
  if f then
    f:write(vim.json.encode(allowed))
    f:close()
  end
end

if vim.g.project and vim.g.mini_files_focus == nil and next(allowed) ~= nil then
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
        pattern = "MiniFilesWindowUpdate",
        callback = function(args)
          local win_id = args.data.win_id
          local config = vim.api.nvim_win_get_config(win_id)
          if not config.title then
            return
          end
          local title = type(config.title) == "table" and config.title[1][1] or config.title
          title = title:gsub("%s%[[FG ]*%]$", "")
          local parts = {}
          if vim.g.mini_files_focus then
            table.insert(parts, "F")
          end
          if show_gitignore then
            table.insert(parts, "G")
          end
          if #parts > 0 then
            title = title .. " [" .. table.concat(parts, " ") .. "]"
          end
          config.title = title
          vim.api.nvim_win_set_config(win_id, config)
        end,
      })

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
              save_allowed()
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
