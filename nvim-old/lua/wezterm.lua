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

local get_selected_text = require("utils").get_selected_text
vim.keymap.set("x", "<leader>x", function()
  last_cmd = get_selected_text()
  exec(last_cmd)
end, { desc = "e[x]ecute visual selection as shell command" })
