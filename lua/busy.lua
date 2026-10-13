-- Statusline spinners (see plugins/lualine.lua) for Claude Code and for
-- slow commands in nvim terminals.
-- Claude's hooks call these over $NVIM (see ~/.claude/hooks/matrix.sh):
--   start  - a prompt was submitted
--   resume - a tool finished; Claude is still going
--   stop   - Claude finished or needs you
-- Interrupting (Esc / Ctrl+C in the Claude terminal) fires no hook, so
-- those keys stop Claude's spinner directly.
-- Terminals: zsh sends OSC 9999 busy;<name> / idle around each command
-- (see ~/.zshrc); commands still running after TERM_DELAY_MS spin.
local M = {}

local FRAME_MS = 80
local TERM_DELAY_MS = 2000
local SPINNER = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local INTERRUPT_KEYS = { ["\27"] = true, ["\3"] = true }

local ticker, frame = nil, 1
local tasks, pending = {}, {}

local function refresh()
  require("lualine").refresh({ place = { "statusline" } })
end

local function find(key)
  for i, task in ipairs(tasks) do
    if task.key == key then
      return i
    end
  end
end

local function sync_ticker()
  if #tasks > 0 and not ticker then
    ticker = vim.uv.new_timer()
    ticker:start(0, FRAME_MS, vim.schedule_wrap(function()
      frame = frame % #SPINNER + 1
      refresh()
    end))
  elseif #tasks == 0 and ticker then
    ticker:stop()
    ticker:close()
    ticker = nil
  end
  refresh()
end

local function add(key, name)
  if not find(key) then
    table.insert(tasks, { key = key, name = name })
    sync_ticker()
  end
end

local function remove(key)
  if pending[key] then
    pending[key]:stop()
    pending[key]:close()
    pending[key] = nil
  end
  local i = find(key)
  if i then
    table.remove(tasks, i)
    sync_ticker()
  end
end

function M.status()
  local parts = {}
  for _, task in ipairs(tasks) do
    table.insert(parts, SPINNER[frame] .. " " .. task.name)
  end
  return table.concat(parts, " · ")
end

function M.start()
  add("claude", "Claude")
end

M.resume = M.start

function M.stop()
  remove("claude")
end

vim.on_key(function(_, typed)
  if not find("claude") or not INTERRUPT_KEYS[typed] or vim.api.nvim_get_mode().mode ~= "t" then
    return
  end
  local ok, term = pcall(require, "claudecode.terminal")
  if ok and vim.api.nvim_get_current_buf() == term.get_active_terminal_bufnr() then
    vim.schedule(M.stop)
  end
end, vim.api.nvim_create_namespace("claude_busy"))

local group = vim.api.nvim_create_augroup("busy_terminals", { clear = true })

vim.api.nvim_create_autocmd("TermRequest", {
  group = group,
  callback = function(ev)
    local seq = type(ev.data) == "table" and ev.data.sequence or ev.data
    local buf = ev.buf
    local name = seq:match("9999;busy;([^\7\27]+)")
    if name then
      remove(buf)
      pending[buf] = vim.defer_fn(function()
        pending[buf] = nil
        add(buf, name)
      end, TERM_DELAY_MS)
    elseif seq:find("9999;idle") then
      remove(buf)
    end
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  group = group,
  callback = function(ev)
    remove(ev.buf)
  end,
})

return M
