return {
  "ibhagwan/fzf-lua",
  -- enabled = false,
  opts = {
    oldfiles = {
      include_current_session = true,
    },
    previewers = {
      builtin = {
        syntax_limit_b = 1024 * 100,
        snacks_image = { enabled = false, render_inline = false },
      },
    },
    winopts = {
      fullscreen = true,

      preview = {
        layout = "vertical",
        vertical = "up:45%",
      },
    },
    keymap = {
      fzf = {
        -- use cltr-q to select all items and convert to quickfix list
        ["ctrl-q"] = "select-all+accept",
      },
    },
  },
  keys = {
    { "<leader><space>", LazyVim.pick("live_grep", { root = false, hidden = true }), desc = "Grep (cwd)" },
    { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    { "<leader>fl", "<cmd>FzfLua blines<cr>", desc = "Find Files (cwd)" },
  },
}
