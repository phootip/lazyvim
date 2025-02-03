return {
  "ibhagwan/fzf-lua",
  opts = {
    oldfiles = {
      include_current_session = true,
    },
    previewers = {
      builtin = {
        syntax_limit_b = 1024 * 100,
      },
    },
    keymap = {
      fzf = {
        -- use cltr-q to select all items and convert to quickfix list
        ["ctrl-q"] = "select-all+accept",
      },
    },
  },
}
