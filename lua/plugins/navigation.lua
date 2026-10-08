-- Directional window movement and resizing that works from anywhere: code
-- buffers, the Claude pane, nvim terminals, and across tmux panes at the edge
-- of nvim. Ctrl moves, Alt+Shift resizes (plain Alt+j/k is LazyVim's move-line).
-- The tmux side of the handshake lives in ~/dotfiles/tmux.conf and must use
-- the same keys. Add a direction here and there, nowhere else.
local DIRECTIONS = {
  { key = "<C-h>", resize_key = "<M-H>", move = "left" },
  { key = "<C-j>", resize_key = "<M-J>", move = "up" },
  { key = "<C-k>", resize_key = "<M-K>", move = "down" },
  { key = "<C-l>", resize_key = "<M-L>", move = "right" },
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
  table.insert(keys, {
    d.resize_key,
    function()
      require("smart-splits")["resize_" .. d.move]()
    end,
    mode = { "n", "t" },
    desc = "Resize window " .. d.move,
  })
end

return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  opts = { at_edge = "stop" },
  keys = keys,
}
