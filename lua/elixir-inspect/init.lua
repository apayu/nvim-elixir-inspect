local M = {}

M.config = {
  symbol = "🔍 >>>>>>>",
  keymap_insert = "<C-e>i"
}

local function get_current_function_name()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local current_line = cursor_pos[1]

  while current_line > 0 do
    local line = vim.api.nvim_buf_get_lines(0, current_line - 1, current_line, false)[1]
    if line then
        local def_pattern = "^%s*def[p]?%s+([a-zA-Z_][a-zA-Z0-9_?!]*)"
        local func_name = string.match(line, def_pattern)
        if func_name then
            return func_name
        end
    end
    current_line = current_line - 1
  end

  return "unknown_function"
end

function M.insert_io_inspect()
  local symbol = M.config.symbol
  local func_name = get_current_function_name()
  local inspect_text = string.format('IO.inspect("%s", label: "%s")', symbol, func_name)
  local current_line = vim.api.nvim_get_current_line()
  local indent = string.match(current_line, "^%s*")
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, line_num-1, line_num-1, true, {indent .. inspect_text})
  vim.api.nvim_win_set_cursor(0, {line_num, #(indent .. inspect_text)})
end

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})

  vim.api.nvim_create_user_command('InsertIOInspect', function()
    M.insert_io_inspect()
  end, {})

  if M.config.keymap_insert then
    vim.keymap.set('i', M.config.keymap_insert, function()
      M.insert_io_inspect()
    end, { noremap = true, silent = true, desc = "Insert IO.inspect" })
  end
end

return M
