-- Error and warning notifications default to the same 3s as info, which
-- isn't long enough to read an LSP or formatter failure before it fades.
-- Keep those on screen for 8s; info stays at the default. Appended via a
-- function because lazy.nvim replaces list opts instead of merging them,
-- and a plain `routes = {}` table would drop LazyVim's own routes.
return {
  "folke/noice.nvim",
  opts = function(_, opts)
    opts.routes = opts.routes or {}
    for _, filter in ipairs({ { error = true }, { warning = true } }) do
      filter.event = "notify"
      table.insert(opts.routes, { filter = filter, view = "notify", opts = { timeout = 8000 } })
    end
  end,
}
