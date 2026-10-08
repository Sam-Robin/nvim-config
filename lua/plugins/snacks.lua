-- Show dotfiles and gitignored files in the explorer and file picker.
-- Repos ignore tmp/, log/ and generated dumps, and .env is a dotfile;
-- hiding those made files that exist on disk look missing. Ctrl+B /
-- Ctrl+P now list them; `H` / `I` in the explorer still toggle them
-- off per session.
--
-- LazyVim gives snacks terminals their own buffer-local Ctrl-h/j/k/l
-- (plain wincmd), which shadow the smart-splits mappings in
-- navigation.lua. Drop them so the terminal pane moves like everything else.
return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      win = {
        keys = { nav_h = false, nav_j = false, nav_k = false, nav_l = false },
      },
    },
    picker = {
      sources = {
        explorer = { hidden = true, ignored = true },
        files = { hidden = true, ignored = true },
      },
    },
  },
}
