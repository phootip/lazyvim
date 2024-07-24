-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.termap")
require("config.termap").init_highlights()
require("config.termap").run_autocommands()
