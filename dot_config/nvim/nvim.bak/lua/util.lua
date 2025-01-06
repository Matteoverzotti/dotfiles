local util = {}

function util.shell_split(line)
  line = line or ''
  local len = string.len(line)

  local args = {}
  local escaped = false
  local start = 1
  local bounded = nil
  local token = {}
  for i=1,len do
    local c = string.sub(line, i, i)
    if escaped then
      table.insert(token, c)
      escaped = false
    elseif c == '\\' then
      escaped = true
    elseif bounded ~= nil then
      if c == bounded then
        bounded = nil
      else
        table.insert(token, c)
      end
    elseif c == ' ' or c == '\t' then
      if next(token) ~= nil then
        table.insert(args, table.concat(token, ''))
        token = {}
      end
    elseif c == '"' or c == "'" then
      bounded = c
    else 
      table.insert(token, c)
    end
  end
  if next(token) ~= nil then
    table.insert(args, table.concat(token, ''))
  end
  return args
end

return util


