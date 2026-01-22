-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- NOTE: SECTION: Basic Remaps
vim.keymap.set("x", "p", "P")
vim.keymap.set("x", "P", "p")
vim.keymap.set({ "n", "x" }, "x", '"_x')
vim.keymap.set({ "n", "x" }, "X", '"_X')
vim.keymap.set("n", "dx", '""dd')
-- vim.keymap.set({ "o" }, "il", "^g_", { desc = "Inner line (non-blank)" })
--
-- NOTE: SECTION: Custom Text Objects
vim.keymap.set({ "o", "x" }, "i ", "iW", { desc = "Inner WORD" })
local function select_il()
  local line = vim.fn.line(".")

  local col_start = vim.fn.match(vim.fn.getline(line), "\\S") + 1
  if col_start == 0 then
    col_start = 1
  end

  local col_end = vim.fn.matchend(vim.fn.getline(line), "\\s*$")
  if col_end == 0 then
    col_end = vim.fn.col("$") - 1
  end

  vim.fn.setpos("'<", { 0, line, col_start, 0 })
  vim.fn.setpos("'>", { 0, line, col_end, 0 })
  vim.cmd("normal! gv")
end

local function select_al()
  local line = vim.fn.line(".")
  local col_start = 1
  local col_end = vim.fn.col("$") - 1

  vim.fn.setpos("'<", { 0, line, col_start, 0 })
  vim.fn.setpos("'>", { 0, line, col_end, 0 })
  vim.cmd("normal! gv")
end

vim.keymap.set("x", "il", select_il, { desc = "inner line (^vg_)" })
vim.keymap.set("x", "al", select_al, { desc = "around line (0v$h)" })
vim.keymap.set("o", "il", select_il, { desc = "inner line (^vg_)" })
vim.keymap.set("o", "al", select_al, { desc = "around line (0v$h)" })

-- NOTE: SECTION: Comment Toggling
vim.keymap.set("n", "<c-_>", "gcc", { remap = true })
vim.keymap.set("n", "<c-/>", "gcc", { remap = true })
vim.keymap.set("v", "<C-_>", "gc", { remap = true })
vim.keymap.set("v", "<C-/>", "gc", { remap = true })

-- NOTE: SECTION: Join lines
vim.keymap.set("v", "J", "gJ", { silent = true })
vim.keymap.set("v", "gJ", "J", { silent = true })

-- vim.keymap.set({ "n", "x", "i", "t" }, "<C-h>", "<CMD>TmuxNavigateLeft<CR>", { silent = true })
-- vim.keymap.set({ "n", "x", "i", "t" }, "<C-j>", "<CMD>TmuxNavigateDown<CR>", { silent = true })
-- vim.keymap.set({ "n", "x", "i", "t" }, "<C-k>", "<CMD>TmuxNavigateUp<CR>", { silent = true })
-- vim.keymap.set({ "n", "x", "i", "t" }, "<C-l>", "<CMD>TmuxNavigateRight<CR>", { silent = true })

-- NOTE: SECTION: Tab and Window Navigation
vim.keymap.set({ "n", "x", "i" }, "<M-u>", "<cmd>tabp<cr>")
vim.keymap.set({ "n", "x", "i" }, "<M-i>", "<cmd>tabn<cr>")
vim.keymap.set({ "n", "x", "i", "t" }, "<M-h>", "<cmd>wincmd h<cr>")
vim.keymap.set({ "n", "x", "i", "t" }, "<M-j>", "<cmd>wincmd j<cr>")
vim.keymap.set({ "n", "x", "i", "t" }, "<M-k>", "<cmd>wincmd k<cr>")
vim.keymap.set({ "n", "x", "i", "t" }, "<M-l>", "<cmd>wincmd l<cr>")
vim.keymap.set({ "n", "x", "i", "t" }, "<M-6>", function()
  print("buftype: " .. vim.o.buftype)
  print("filetype: " .. vim.o.filetype)
end)

-- NOTE: SECTION: Terminal Tab Navigation
vim.keymap.set({ "t" }, "<M-u>", function()
  vim.cmd("stopinsert")
  -- using vim.cmd("tabp") breaks cursor pos, why?
  local keys = vim.api.nvim_replace_termcodes("<M-u>", true, false, true)
  vim.api.nvim_feedkeys(keys, "m", false)
end)
vim.keymap.set({ "t" }, "<M-i>", function()
  local keys = vim.api.nvim_replace_termcodes("<M-i>", true, false, true)
  if vim.o.filetype == "fzf" then
    vim.api.nvim_feedkeys(keys, "n", false)
  else
    vim.cmd("stopinsert")
    -- using vim.cmd("tabp") breaks cursor pos, why?
    vim.api.nvim_feedkeys(keys, "m", false)
  end
end)

-- NOTE: SECTION: Fold
-- Function to fold all headings of a specific level
local function fold_headings_of_level(level)
  -- Move to the top of the file without adding to jumplist
  vim.cmd("keepjumps normal! gg")
  -- Get the total number of lines
  local total_lines = vim.fn.line("$")
  for line = 1, total_lines do
    -- Get the content of the current line
    local line_content = vim.fn.getline(line)
    -- "^" -> Ensures the match is at the start of the line
    -- string.rep("#", level) -> Creates a string with 'level' number of "#" characters
    -- "%s" -> Matches any whitespace character after the "#" characters
    -- So this will match `## `, `### `, `#### ` for example, which are markdown headings
    if line_content:match("^" .. string.rep("#", level) .. "%s") then
      -- Move the cursor to the current line without adding to jumplist
      vim.cmd(string.format("keepjumps call cursor(%d, 1)", line))
      -- Check if the current line has a fold level > 0
      local current_foldlevel = vim.fn.foldlevel(line)
      if current_foldlevel > 0 then
        -- Fold the heading if it matches the level
        if vim.fn.foldclosed(line) == -1 then
          vim.cmd("normal! za")
        end
        -- else
        --   vim.notify("No fold at line " .. line, vim.log.levels.WARN)
      end
    end
  end
end

local function fold_markdown_headings(levels)
  -- I save the view to know where to jump back after folding
  local saved_view = vim.fn.winsaveview()
  for _, level in ipairs(levels) do
    fold_headings_of_level(level)
  end
  vim.cmd("nohlsearch")
  -- Restore the view to jump to where I was
  vim.fn.winrestview(saved_view)
end

-- Keymap for folding markdown headings of level 1 or above
vim.keymap.set("n", "zh", function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd("silent update")
  -- vim.keymap.set("n", "<leader>mfj", function()
  -- Reloads the file to refresh folds, otheriise you have to re-open neovim
  vim.cmd("edit!")
  -- Unfold everything first or I had issues
  vim.cmd("normal! zR")
  fold_markdown_headings({ 6, 5, 4, 3, 2, 1 })
  vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold all headings level 1 or above" })

-- Keymap for folding markdown headings of level 2 or above
-- I know, it reads like "madafaka" but "k" for me means "2"
vim.keymap.set("n", "zj", function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd("silent update")
  -- vim.keymap.set("n", "<leader>mfk", function()
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd("edit!")
  -- Unfold everything first or I had issues
  vim.cmd("normal! zR")
  fold_markdown_headings({ 6, 5, 4, 3, 2 })
  vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold all headings level 2 or above" })

-- Keymap for folding markdown headings of level 3 or above
vim.keymap.set("n", "zk", function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd("silent update")
  -- vim.keymap.set("n", "<leader>mfl", function()
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd("edit!")
  -- Unfold everything first or I had issues
  vim.cmd("normal! zR")
  fold_markdown_headings({ 6, 5, 4, 3 })
  vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold all headings level 3 or above" })

-- Keymap for folding markdown headings of level 4 or above
vim.keymap.set("n", "zl", function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd("silent update")
  -- vim.keymap.set("n", "<leader>mf;", function()
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd("edit!")
  -- Unfold everything first or I had issues
  vim.cmd("normal! zR")
  fold_markdown_headings({ 6, 5, 4 })
  vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold all headings level 4 or above" })

-- Use <CR> to fold when in normal mode
-- To see help about folds use `:help fold`
-- vim.keymap.set("n", "<CR>", function()
--   -- Get the current line number
--   local line = vim.fn.line(".")
--   -- Get the fold level of the current line
--   local foldlevel = vim.fn.foldlevel(line)
--   if foldlevel == 0 then
--     vim.notify("No fold found", vim.log.levels.INFO)
--   else
--     vim.cmd("normal! za")
--     vim.cmd("normal! zz") -- center the cursor line on screen
--   end
-- end, { desc = "[P]Toggle fold" })

-- old: unfold next foldable
vim.keymap.set({ "n" }, "<Enter>", function()
  if vim.o.buftype ~= "quickfix" and vim.o.filetype ~= "vim" then
    local line = vim.fn.line(".")
    if vim.fn.foldclosed(line) ~= -1 then
      return "zo"
    else
      return "zjzo"
    end
  else
    return "<Enter>"
  end
end, { expr = true, replace_keycodes = true })
vim.keymap.set({ "n" }, "<BS>", "zc")

-- NOTE: SECTION: Terminal
vim.keymap.set("", "H", "^")
vim.keymap.set("", "L", "g_")
vim.keymap.set("n", "]<Tab>", "<cmd>tabnext<cr>")
vim.keymap.set("n", "[<Tab>", "<cmd>tabprevious<cr>")
vim.keymap.set("n", "<leader>tt", "<cmd>tabnew | term<cr>")
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>")
vim.keymap.set("n", "<leader>td", "<cmd>tabclose<cr>")
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<cr>")
vim.keymap.set("n", "<leader>tr", "<cmd>TabRename <cr>")
-- vim.keymap.set("n", "<leader>t", function()
--   require("which-key").show({ keys = "<leader>t", loop = true })
-- end)

-- NOTE: SECTION: Terminal Mode Escape
vim.keymap.set({ "t" }, "<F1>", "<c-\\><c-n>")
vim.keymap.set({ "x", "i" }, "<F1>", "<ESC>")
vim.keymap.set({ "n" }, "<F1>", "<CMD>noh<CR><ESC>")
-- vim.keymap.set({ "t" }, "<F1>", "<esc>")
-- vim.keymap.set({ "t" }, "<M-esc>", "<esc>")

-- NOTE: SECTION: Quit Remap
vim.keymap.set({ "n" }, "q", function()
  if vim.bo.buftype == "terminal" then
    vim.api.nvim_feedkeys("i", "n", true)
  else
    vim.api.nvim_feedkeys("q", "n", true)
  end
end)

-- NOTE: SECTION: UI
vim.keymap.del("n", "<leader>us")
vim.keymap.set({ "n" }, "<leader>us", "<CMD>SmearCursorToggle<CR>", { silent = true, desc = "Toggle Smear Cursor" })

-- vim.keymap.set("n", "<leader>.", "<cmd>@:<cr>")
-- NOTE: SECTION: Diff
vim.keymap.set("n", "<leader>dd", function()
  if vim.wo.diff then
    vim.cmd("windo diffoff")
  else
    vim.cmd("windo diffthis")
  end
end)
vim.keymap.set("n", "<leader>dgo", "<cmd>diffget<cr>")
vim.keymap.set("n", "<leader>dgl", "<cmd>.,.diffget<cr>")
vim.keymap.set("x", "<leader>dgo", "<cmd>'<,'>diffget<cr>")
vim.keymap.set("n", "<leader>dpp", "<cmd>diffput<cr>")
vim.keymap.set("n", "<leader>dpl", "<cmd>.,.diffput<cr>")
vim.keymap.set("x", "<leader>dpp", "<cmd>'<,'>diffput<cr>")

-- terminal change mode
-- vim.api.nvim_del_keymap("t", "<Esc><Esc>")
-- vim.keymap.set({ "t" }, "<esc><esc>", "<c-\\><c-n>")
-- vim.keymap.set({ "t" }, "<esc>", "<c-\\><c-n>")
-- vim.keymap.set({ "t" }, "<C-q>", "<c-\\><c-n>")

-- NOTE: SECTION: Yank File/Path
-- yank filename only
vim.keymap.set("n", "<leader>yf", function()
  local filename = vim.fn.expand("%:t")
  vim.fn.setreg("+", filename)
  print("Yanked: " .. filename)
end, { desc = "Yank filename only" })

-- yank file absolute path
vim.keymap.set("n", "<leader>yF", function()
  local filepath = vim.fn.expand("%:p")
  vim.fn.setreg("+", filepath)
  print("Yanked: " .. filepath)
end, { desc = "Yank file absolute path" })

-- yank filepath relative to cwd
vim.keymap.set("n", "<leader>yp", function()
  local filepath = vim.fn.expand("%:.")
  vim.fn.setreg("+", filepath)
  print("Yanked: " .. filepath)
end, { desc = "Yank filepath relative to cwd" })

-- yank file absolute path
vim.keymap.set("n", "<leader>yP", function()
  local filepath = vim.fn.expand("%:p")
  vim.fn.setreg("+", filepath)
  print("Yanked: " .. filepath)
end, { desc = "Yank file absolute path" })

-- yank directory path relative to cwd
vim.keymap.set("n", "<leader>yd", function()
  local dirpath = vim.fn.expand("%:.:h")
  vim.fn.setreg("+", dirpath)
  print("Yanked: " .. dirpath)
end, { desc = "Yank directory path relative to cwd" })

-- yank path+line format
vim.keymap.set({ "n", "v" }, "<leader>yl", function()
  local filepath = vim.fn.expand("%:.")
  local line_start = vim.fn.line(".")
  local result

  if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
    local line_end = vim.fn.line("v")
    if line_start > line_end then
      line_start, line_end = line_end, line_start
    end
    result = filepath .. " L" .. line_start .. ":" .. line_end
  else
    result = filepath .. " L" .. line_start
  end

  vim.fn.setreg("+", result)
  print("Yanked: " .. result)
end, { desc = "Yank path+line format" })

-- NOTE: SECTION: Multicursor
-- mutlicusor
vim.api.nvim_del_keymap("n", "<esc>")
local mc = require("multicursor-nvim")
local keys = vim.api.nvim_replace_termcodes("<cmd>noh<cr><esc>", true, false, true)
vim.keymap.set("n", "<esc>", function()
  if not mc.cursorsEnabled() then
    mc.enableCursors()
  elseif mc.hasCursors() then
    mc.clearCursors()
  else
    vim.api.nvim_feedkeys(keys, "n", true)
  end
end)
