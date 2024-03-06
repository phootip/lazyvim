vim.api.nvim_create_user_command("ObsidianNewDefaultTemplate", function()
  vim.cmd("ObsidianNew")
  vim.cmd("normal! ggO") -- add properties at the start
  vim.cmd("ObsidianTemplate default.md")
  vim.cmd("normal! ddG") -- go to end of file
end, {})

return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/phootip/personal/notes",
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
  },
  keys = {
    { "<leader>nd", "<CMD>ObsidianToday<CR>", silent = true, mode = { "n" }, desc = "Today note" },
    { "<leader>nn", "<CMD>ObsidianNewDefaultTemplate<CR>", silent = true, mode = { "n" }, desc = "Today note" },
    { "<leader>nt", "<CMD>ObsidianTemplate<CR>", silent = true, mode = { "n" }, desc = "Today note" },
  },
}
