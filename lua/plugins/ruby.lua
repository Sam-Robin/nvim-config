-- ruby-lsp is installed as a global gem via asdf, not through Mason. LazyVim
-- only auto-enables Mason-installed servers, so without `mason = false` the
-- server is configured but never started and `gd` silently does nothing.
-- Using the PATH binary also keeps ruby-lsp-rails in the project's bundle,
-- which is what indexes models, associations and routes.
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ruby_lsp = { mason = false },
    },
  },
}
