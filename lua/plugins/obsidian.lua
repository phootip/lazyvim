-- NOTE: note taking
vim.api.nvim_create_user_command("ObsidianNewDefaultTemplate", function()
  vim.cmd("ObsidianNew")
  vim.cmd("normal! ggO") -- add properties at the start
  vim.cmd("ObsidianTemplate default.md")
  vim.cmd("normal! ddG") -- go to end of file
end, {})

local repo_note_win = nil
local repo_note_buf = nil

local function openRepoNote()
  if repo_note_win and vim.api.nvim_win_is_valid(repo_note_win) then
    vim.api.nvim_win_close(repo_note_win, true)
    repo_note_win = nil
    repo_note_buf = nil
    return
  end

  local file_name = vim.fs.basename(vim.fn.getcwd())

  -- Try to get git remote URL
  local git_remote = vim.fn.system("git config --get remote.origin.url 2>/dev/null")
  if vim.v.shell_error == 0 and git_remote ~= "" then
    git_remote = git_remote:gsub("%s+$", "") -- trim whitespace
    -- Parse git@github.com:owner/repo.git or https://github.com/owner/repo.git
    local owner, repo = git_remote:match("git@[^:]+:([^/]+)/(.+)%.git")
    if not owner then
      owner, repo = git_remote:match("https?://[^/]+/([^/]+)/(.+)%.git")
    end
    if owner and repo then
      file_name = owner .. "__" .. repo
    end
  end

  local file_location = vim.fn.expand("~/OneDrive/notes/2 repos/" .. file_name .. ".md")

  repo_note_buf = vim.api.nvim_create_buf(true, false)

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local win_opts = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    -- style = "minimal",
    border = "rounded",
  }

  repo_note_win = vim.api.nvim_open_win(repo_note_buf, true, win_opts)
  vim.api.nvim_set_option_value("winhl", "Normal:NormalFloat,FloatBorder:FloatBorder", { win = repo_note_win })

  local f = vim.fn.filereadable(file_location)
  if f == 0 then
    vim.api.nvim_buf_set_name(repo_note_buf, file_location)
    vim.cmd("normal! ggO") -- add properties at the start
    vim.cmd("ObsidianTemplate repo.md")
    vim.cmd("normal! ddG") -- go to end of file
    vim.api.nvim_set_current_line("# " .. file_name)
    vim.cmd("normal! o") -- go to end of file
    vim.cmd("w") -- go to end of file
  else
    vim.cmd("edit " .. file_location)
  end

  vim.api.nvim_buf_set_keymap(repo_note_buf, "n", "q", "<cmd>close<cr>", { noremap = true, silent = true })
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  -- version = false,
  lazy = true,
  ft = "markdown",
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/OneDrive/notes",
      },
    },
    daily_notes = {
      folder = "Daily",
      date_format = "%Y-%m-%d",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = "daily.md",
    },
    templates = {
      subdir = "Templater/neovim",
      time_format = "%H:%M:%S%Z:00",
    },
    notes_subdir = "1 inbox",
    new_notes_location = "notes_subdir",
    note_id_func = function(title)
      if title ~= nil then
        return title
      end
    end,
    disable_frontmatter = true,
    note_frontmatter_func = function(note)
      local output = { tags = note.tags }
      output["createdAt"] = tostring(os.date("%Y-%m-%dT%H:%M:%S%Z:00"))
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          output[k] = v
        end
      end
      return output
    end,
    completion = {
      blink = true, -- if not set, might have issue with lazy loading
      min_chars = 0,
    },
  },
  keys = {
    { "<leader>nd", "<CMD>ObsidianToday<CR>", silent = true, mode = { "n" }, desc = "Today note" },
    { "<leader>nn", "<CMD>ObsidianNewDefaultTemplate<CR>", silent = true, mode = { "n" }, desc = "Today note" },
    { "<leader>nr", openRepoNote, silent = true, mode = { "n" }, desc = "Open Repo Note" },
    -- { "<leader>nt", "<CMD>ObsidianTemplate<CR>", silent = true, mode = { "n" }, desc = "Today note" },
  },
}
