local M = {}

M.config = {
  max_column_width = 50,
}

M.original_content = {}
M.column_positions = {}
M.optimal_widths = {}

function M.setup(opts)
  M.config = vim.tbl_extend('force', M.config, opts or {})

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'dbout',
    callback = function()
      M.setup_buffer()
    end,
  })
end

function M.setup_buffer()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  M.original_content[buf] = lines
  M.column_positions[buf] = M.parse_column_positions(lines)
  M.optimal_widths[buf] = M.calculate_optimal_width(buf, lines)

  M.truncate_colums(buf)
  print(#lines)
end

function M.parse_column_positions(lines)
  local separator_line = nil
  for _, line in pairs(lines) do
    if line:match '^%-+' then
      separator_line = line
      break
    end
  end

  if not separator_line then
    return nil
  end

  local column_positions = {}
  local start = 1
  local in_column = false

  for i = 1, #separator_line do
    local char = separator_line:sub(i, i)

    if char == '-' and not in_column then
      in_column = true
      start = i
    elseif char ~= '-' and in_column then
      table.insert(column_positions, { start_pos = start, end_pos = i - 1 })
      in_column = false
    end
  end

  if in_column then
    table.insert(column_positions, { start_pos = start, end_pos = #separator_line })
  end

  return column_positions
end

function M.calculate_optimal_width(buf, lines)
  local column_positions = M.column_positions[buf]

  if not column_positions then
    return
  end

  local widths = {}
  for i = 1, #column_positions do
    widths[i] = 0
  end

  for line_num, line in ipairs(lines) do
    for col_id, col_pos in ipairs(column_positions) do
      if line_num ~= 2 and not line:match '%(.*rows.*%)' then
        local col_start = col_pos.start_pos
        local col_end = math.min(col_pos.end_pos, #line)
        local cell_value = vim.trim(line:sub(col_start, col_end))

        widths[col_id] = math.max(widths[col_id], #cell_value)
      end
    end
  end

  for i = 1, #widths do
    widths[i] = math.min(widths[i], M.config.max_column_width)
  end

  return widths
end

function M.truncate_colums(buf)
  local lines = M.original_content[buf]
  local column_positions = M.column_positions[buf]
  local optimal_widths = M.optimal_widths[buf]

  if not lines or not column_positions then
    return
  end

  vim.bo[buf].modifiable = true
  local truncated = {}

  for line_num, line in ipairs(lines) do
    if line_num ~= 2 and not line:match '%(.*rows.*%)' then
      table.insert(truncated, line)
    else
      local new_line = {}

      for col_id, col_pos in ipairs(column_positions) do
        local col_start = col_pos.start_pos
        local col_end = math.min(col_pos.end_pos, #line)
        local cell_value = vim.trim(line:sub(col_start, col_end))
        local optimal_width = optimal_widths and optimal_widths[col_id] or M.config.max_column_width

        if #cell_value > optimal_width then
          if line_num > 2 then
            cell_value = cell_value:sub(1, optimal_width - #'...') .. '...'
          else
            cell_value = cell_value:sub(1, optimal_width)
          end
        end

        -- local col_width = col_end - col_start + 1
        -- local display_width = math.min(col_width, M.config.max_column_width + #'...')

        cell_value = cell_value .. string.rep(' ', math.max(0, optimal_width - #cell_value))

        table.insert(new_line, cell_value)
      end

      table.insert(truncated, table.concat(new_line, ' '))
    end
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, truncated)

  vim.bo[buf].modifiable = false
end

return M
