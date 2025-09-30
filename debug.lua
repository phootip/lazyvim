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

function fibonacci(n)
  if n < 2 then
    return n
  else
    return fibonacci(n - 1) + fibonacci(n - 2)
  end
end

local lualine = require("lualine")
print(dump(lualine))
