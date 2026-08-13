# Neovim config

Personal [LazyVim](https://github.com/LazyVim/LazyVim) setup. Ruby/Rails + React/TypeScript.

## Install

Requires Neovim >= 0.9, `git`, and a [Nerd Font](https://www.nerdfonts.com/) for icons.

```sh
# back up any existing config first
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}

git clone git@github.com:Sam-Robin/nvim-config.git ~/.config/nvim
nvim
```

Plugins install themselves on first launch. `lazy-lock.json` pins exact versions, so a
fresh clone reproduces this setup precisely — run `:Lazy update` to move forward and
commit the changed lockfile.

## Layout

| Path | Purpose |
| --- | --- |
| `init.lua` | Entry point — bootstraps `config.lazy` |
| `lua/config/lazy.lua` | lazy.nvim bootstrap + LazyVim import |
| `lua/config/keymaps.lua` | Custom keymaps (VS Code-style layer) |
| `lua/config/options.lua` | Vim options |
| `lua/config/autocmds.lua` | Autocommands |
| `lua/plugins/lang.lua` | Language extras: Ruby, TypeScript, JSON |
| `lua/plugins/gitsigns.lua` | Inline git blame (GitLens-style) |
| `lazy-lock.json` | Pinned plugin versions — commit changes to this |

## Custom keymaps

Leader is `<Space>`. These sit on top of the LazyVim defaults.

| Key | Action |
| --- | --- |
| `<C-s>` | Save (normal/insert/visual) |
| `<C-p>` | Find file |
| `<C-b>` | Toggle file explorer |
| `<C-f>` | Search in current file |
| `<C-/>` | Toggle comment |
| `<leader>P` | Command palette |
| `<leader>F` | Grep project |
| `<leader>uB` | Toggle inline git blame |

`<C-s>` needs `stty -ixon` in your shell rc, or the terminal freezes on Ctrl+S instead
of saving.

## Terminal notes

Apple Terminal can't distinguish some control sequences: `<C-h>` arrives as Backspace,
and `<C-/>` arrives as `<C-_>` (both are bound). A kitty-protocol terminal — Ghostty,
kitty, WezTerm — avoids these entirely.
