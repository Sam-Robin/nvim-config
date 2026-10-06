-- Directional window movement that works from anywhere: code buffers, the
-- Claude pane, nvim terminals, and across tmux panes at the edge of nvim.
-- The tmux side of the handshake lives in ~/dotfiles/tmux.conf and must use
-- the same keys. Add a direction here and there, nowhere else.
local DIRECTIONS = {
  { key = "<C-h>", move = "left" },
  { key = "<C-j>", move = "down" },
  { key = "<C-k>", move = "up" },
  { key = "<C-l>", move = "right" },
}

local keys = {}
for _, d in ipairs(DIRECTIONS) do
  table.insert(keys, {
    d.key,
    function()
      require("smart-splits")["move_cursor_" .. d.move]()
    end,
    mode = { "n", "t" },
    desc = "Go to " .. d.move .. " window",
  })
end

return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  opts = { at_edge = "stop" },
  keys = keys,
}
