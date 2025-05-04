local log_file_path = (os.getenv("HOME") or os.getenv("USERPROFILE")) .. "/Desktop/nvim.log"

local function ensure_logfile_exists()
  local file = io.open(log_file_path, "r")
  if file == nil then
    file = io.open(log_file_path, "w")
    file:close()
  end

  file:close()
end

function DEBUG_LOG(message)
  ensure_logfile_exists()
  local current_time = os.date("%Y-%m-%d %H:%M:%S")

  local file = io.open(log_file_path, "a")
  file:write(current_time .. " " .. message .. "\n")
  file:close()
end

function File_exists(file)
  local f = io.open(file, "r")
  if f then
    f:close()
    return true
  else
    return false
  end
end
