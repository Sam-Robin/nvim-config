-- ruby-lsp is installed as a global gem via asdf, not through Mason. LazyVim
-- only auto-enables Mason-installed servers, so without `mason = false` the
-- server is configured but never started and `gd` silently does nothing.
-- Using the PATH binary also keeps ruby-lsp-rails in the project's bundle,
-- which is what indexes models, associations and routes.
--
-- RuboCop runs inside ruby-lsp from the project's composed bundle, so it
-- picks up gems the project pulls in (rubocop-florence, custom cops). The
-- separate `rubocop` LSP server and the conform `rubocop` formatter both
-- spawn the global `rubocop` instead, which can't load those gems and fails
-- with "cannot load such file" on every save. Disable the extra server and
-- route formatting through the LSP.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = { mason = false },
        rubocop = { enabled = false },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.ruby = { lsp_format = "prefer" }
    end,
  },
}
