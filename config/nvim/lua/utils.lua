local M = {}

local log_file_path = (os.getenv("HOME") or os.getenv("USERPROFILE")) .. "/Desktop/nvim.log"

local function ensure_logfile_exists()
  local file = io.open(log_file_path, "r")
  if file == nil then
    file = io.open(log_file_path, "w")
    file:close()
  end

  file:close()
end

function M.debug_log(...)
  ensure_logfile_exists()
  local current_time = os.date("%Y-%m-%d %H:%M:%S")

  local values = {}
  for i = 1, select("#", ...) do
    values[i] = tostring(select(i, ...))
  end

  local file = io.open(log_file_path, "a")
  file:write(current_time .. " " .. table.concat(values, "\t") .. "\n")
  file:close()
end

function M.file_exists(file)
  local f = io.open(file, "r")
  if f then
    f:close()
    return true
  else
    return false
  end
end

function M.has_value(array, searched_val)
  for _, val in ipairs(array) do
    if val == searched_val then
      return true
    end
  end
  return false
end

function M.merge_sets(set1, set2)
  local result = set1
  for _, val in ipairs(set2) do
    if not M.has_value(result, val) then
      table.insert(result, val)
    end
  end
  return result
end

-- stylua: ignore
function M.enter_normal()
    vim.cmd("normal! <Esc>")
end

function M.enter_insert()
  M.enter_normal()
  vim.cmd("startinsert")
end

function M.enter_insert_after()
  M.enter_normal()
  vim.cmd("startinsert!")
end

return M
