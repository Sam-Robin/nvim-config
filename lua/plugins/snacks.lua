-- Show gitignored files in the explorer and file picker. Repos ignore
-- tmp/, log/ and generated dumps, and hiding those made files that exist
-- on disk look missing. Ctrl+B / Ctrl+P now list them; `I` / <a-i> still
-- toggles them off per session.
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = { ignored = true },
        files = { ignored = true },
      },
    },
  },
}
