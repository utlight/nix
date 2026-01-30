local M = {}

M.config = {}

function M.setup(opts)
  M.config = vim.tbl_extend('force', M.config, opts or {})

  vim.api.nvim_create_user_command('DBTestConnection', function()
    M.test_connection 'sqlserver://aptadmin:apt303242!@timepoint-dev.database.windows.net:1433/Timepoint_ETimePlus_55'
  end, { nargs = 0, desc = 'huh?' })
end

--connections
M.connections = {}

function M.test_connection(url)
  local success, result = pcall(vim.fn['db#resolve'], url)
  if not success then
    return false, 'Invalid URL: ' .. tostring(result)
  end

  success, result = pcall(vim.cmd(string.format('DB %s SELECT 1', result)))
  if success then
    return true, 'Connection succesfull'
  else
    return false, 'Connection failed: ' .. tostring(result)
  end
end

function M.add_connection(connection)
  M.connections[connection.name] = connection
end

function M.get_connection(name)
  return M.connections[name]
end

function M.list_connections()
  return vim.tbl_values(M.connections)
end

return M
