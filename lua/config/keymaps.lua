-- Keymaps are automatically loaded on the VeryLazy event
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Below: VS Code-style bindings layered on top of those defaults.

local map = vim.keymap.set

-- Ctrl+S save, staying in whatever mode you were in.
-- Needs `stty -ixon` in ~/.zshrc, or the terminal freezes on Ctrl+S instead.
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-- Ctrl+P quick open
map("n", "<C-p>", function()
  Snacks.picker.files()
end, { desc = "Find file" })

-- Ctrl+B toggle file explorer sidebar
map("n", "<C-b>", function()
  Snacks.explorer()
end, { desc = "Toggle explorer" })

-- Ctrl+/ toggle comment. Apple Terminal sends <C-_>; kitty-protocol
-- terminals send a real <C-/>, so bind both.
map("n", "<C-_>", "gcc", { remap = true, desc = "Comment line" })
map("v", "<C-_>", "gc", { remap = true, desc = "Comment selection" })
map("n", "<C-/>", "gcc", { remap = true, desc = "Comment line" })
map("v", "<C-/>", "gc", { remap = true, desc = "Comment selection" })

-- Ctrl+F find in current file
map("n", "<C-f>", "/", { desc = "Search in file" })

-- Ctrl+Shift+P / Ctrl+Shift+F can't be distinguished from their unshifted
-- forms in Apple Terminal, so the palette and project search live on <leader>.
map("n", "<leader>P", function()
  Snacks.picker.commands()
end, { desc = "Command palette" })
map("n", "<leader>F", function()
  Snacks.picker.grep()
end, { desc = "Find in project" })
