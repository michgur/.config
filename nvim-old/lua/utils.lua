function get_selected_text()
  local s = vim.fn.getpos("v")
  local e = vim.fn.getpos(".")
  if s[2] > e[2] then
    s, e = e, s
  elseif s[2] == e[2] then
    if s[3] > e[3] then
      s, e = e, s
    end
    e[3] = e[3] - s[3] + 1
  end

  local lines = vim.api.nvim_buf_get_lines(0, s[2] - 1, e[2], false)
  if #lines == 0 then
    return
  end

  if vim.api.nvim_get_mode().mode == "v" then
    lines[1] = string.sub(lines[1], s[3], #lines[1])
    lines[#lines] = string.sub(lines[#lines], 1, e[3])
  end

  return table.concat(lines, "\n")
end

return {
  get_selected_text = get_selected_text,
}
