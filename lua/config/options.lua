-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.cursorcolumn = true
-- vim.opt.wrap = true
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 0
vim.opt.showtabline = 2
-- vim.opt.conceallevel = 0
vim.opt.autoread = true
vim.opt.timeoutlen = 1000
vim.g.snacks_animate = false
-- vim.opt.fillchars = {}
-- vim.cmd([[highlight Cursor guibg=#000000 guifg=#ff0000]])
-- vim.cmd([[highlight TermCursor guibg=#000000 guifg=#d466d8]])
-- vim.cmd([[highlight TermCursor guibg=#000000 guifg=#cf4c92]])
vim.cmd([[highlight TermCursor guibg=#000000 guifg=#ff0000]])
-- vim.cmd([[highlight Normal guifg=#dcd7ba guibg=#1f2428]])
-- vim.opt.foldmethod = "indent"
-- vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
vim.opt.listchars = "eol:↲,tab:>-,trail:~,extends:>,precedes:<"
-- autoformat toggle <leader>uf
-- vim.g.lazyvim_picker = "fzf"

function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end
