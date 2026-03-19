require("which-key").show({ keys = "<leader>w", loop = true })
local fibonacci = function()
  append = function(tbl, val)
    tbl[#tbl + 1] = val
  end

  fib = { 0, 1 }
  for i = 3, 20 do
    append(fib, fib[i - 1] + fib[i - 2])
  end

  return fib
end
