-- Lua 5.1 does not directly support __gc so this hack is required
-- Lua 5.1 only supports __gc on userdata
-- https://stackoverflow.com/questions/27426704/lua-5-1-workaround-for-gc-metamethod-for-tables

return function(t, gc_fn)
  local mt = {}
  mt.__gc = gc_fn
  if _VERSION == 'Lua 5.1' then
    local prox = newproxy(true)
    getmetatable(prox).__gc = function()
      mt.__gc(t)
    end
    t[prox] = true
  end
  setmetatable(t, mt)
end
