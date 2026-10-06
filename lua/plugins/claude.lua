-- Claude Code inside nvim via the same WebSocket protocol as the official
-- VS Code extension: Claude sees open buffers, selections and diagnostics,
-- and its edits arrive as diffs to accept or deny here. One connection per
-- nvim instance, so a tmux session per worktree gives one Claude per branch.
return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  cmd = { "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeAdd", "ClaudeCodeSend" },
  -- Esc stays with Claude (it interrupts a running turn). Ctrl+Q hides
  -- the pane from inside it; Snacks' built-in double-Esc (within 200ms)
  -- drops to normal mode if you want to scroll instead.
  opts = {
    terminal = {
      snacks_win_opts = {
        keys = {
          claude_hide = {
            "<C-q>",
            function(self)
              self:hide()
            end,
            mode = "t",
            desc = "Hide Claude",
          },
        },
      },
    },
  },
  keys = {
    { "<leader>a", nil, desc = "AI/Claude Code" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
    { "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", desc = "Add file", ft = { "snacks_picker_list", "oil" } },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    {
      "<leader>an",
      function()
        local port = require("claudecode").state.port
        if not port then
          return vim.notify("Open Claude first with <leader>ac", vim.log.levels.WARN)
        end
        if not vim.env.TMUX then
          return vim.notify("Not inside tmux", vim.log.levels.WARN)
        end
        vim.fn.system({
          "tmux", "split-window", "-h", "-c", vim.fn.getcwd(),
          ("ENABLE_IDE_INTEGRATION=true CLAUDE_CODE_SSE_PORT=%d claude"):format(port),
        })
      end,
      desc = "New Claude in tmux pane (shares this nvim)",
    },
    {
      "<leader>aw",
      function()
        if not vim.env.TMUX then
          return vim.notify("Not inside tmux. Start a branch with `wt <branch>`.", vim.log.levels.WARN)
        end
        local sessions = vim.fn.systemlist({ "tmux", "list-sessions", "-F", "#S" })
        vim.ui.select(sessions, { prompt = "Switch worktree" }, function(choice)
          if choice then
            vim.fn.system({ "tmux", "switch-client", "-t", choice })
          end
        end)
      end,
      desc = "Switch worktree session",
    },
  },
}
