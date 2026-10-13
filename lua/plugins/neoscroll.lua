-- Scrolling that streams rather than jumps.
--
-- LazyVim turns on snacks.scroll by default; it's disabled here so
-- neoscroll is the only thing animating <C-d>/<C-u>.
return {
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
}
