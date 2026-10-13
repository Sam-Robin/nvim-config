-- Spinner on the left of the statusline's right half while Claude Code is
-- working. busy.lua drives it from Claude's hooks.
return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, 1, {
      function()
        return require("busy").status()
      end,
      color = function()
        return { fg = Snacks.util.color("DiagnosticOk") }
      end,
    })
  end,
}
