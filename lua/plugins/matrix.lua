-- Matrix vibes: rain the buffer down the screen, green glyphs on the
-- dashboard, and scrolling that streams rather than jumps.
--
-- LazyVim turns on snacks.scroll by default; it's disabled here so
-- neoscroll is the only thing animating <C-d>/<C-u>.
return {
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    keys = {
      { "<leader>ur", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "Make it rain" },
    },
  },
  {
    "folke/snacks.nvim",
    opts = { scroll = { enabled = false } },
  },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
      duration_multiplier = 0.6,
      easing = "quadratic",
    },
  },
  {
    "folke/drop.nvim",
    event = "VimEnter",
    opts = {
      theme = "matrix",
      max = 60,
      interval = 100,
      screensaver = 1000 * 60 * 5,
      filetypes = { "snacks_dashboard" },
    },
  },
}
