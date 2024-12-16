local function get_selected_text()
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

local function wezterm_cmd(cmd)
  local command = vim.deepcopy(cmd)
  table.insert(command, 1, "wezterm")
  table.insert(command, 2, "cli")
  return vim.fn.system(command)
end

local function focus_pane(pane_id)
  wezterm_cmd({ "activate-pane", "--pane-id", tostring(pane_id) })
end

local function may_become_runner(tab)
  return tab.title == "zsh"
end

local function find_or_create_runner_pane()
  local output = wezterm_cmd({ "list", "--format", "json" })

  local data = vim.json.decode(output) --[[@as table]]
  for _, pane in ipairs(data) do
    if may_become_runner(pane) then
      return pane.pane_id
    end
  end

  local output = wezterm_cmd({ "spawn", "--cwd", vim.fn.getcwd(), "--", "zsh" })
  return tonumber(output)
end

local function exec_in_pane(pane_id, cmd)
  local output = wezterm_cmd({ "send-text", "--no-paste", "--pane-id", pane_id, cmd .. "\n" })
  print("Running command: " .. cmd)
end

local function exec(cmd)
  local pane_id = find_or_create_runner_pane()
  focus_pane(pane_id)
  exec_in_pane(pane_id, cmd)
end

local last_cmd = nil
vim.keymap.set("n", "<leader>x", function()
  if last_cmd == nil then
    print("No last command")
  else
    exec(last_cmd)
  end
end, { desc = "E[x]ecute last shell command" })

vim.keymap.set("x", "<leader>x", function()
  last_cmd = get_selected_text()
  exec(last_cmd)
end, { desc = "e[x]ecute visual selection as shell command" })
