-- Show dotfiles and gitignored files in the explorer and file picker.
-- Repos ignore tmp/, log/ and generated dumps, and .env is a dotfile;
-- hiding those made files that exist on disk look missing. Ctrl+B /
-- Ctrl+P now list them; `H` / `I` in the explorer still toggle them
-- off per session.
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = { hidden = true, ignored = true },
        files = { hidden = true, ignored = true },
      },
    },
  },
}
