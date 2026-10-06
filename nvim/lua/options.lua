require "nvchad.options"

-- add yours here!

-- tmux (screen-256color, no COLORTERM) hides truecolor support from nvim's
-- auto-detection, so base46 themes look wrong without this
vim.o.termguicolors = true

-- over SSH, yank to the local machine's clipboard via OSC 52 (needs
-- `set -s set-clipboard on` in tmux). paste reads nvim's own registers instead:
-- OSC 52 paste is unsupported by most terminals and would stall every `p`.
-- (paste from your OS clipboard with your terminal's paste key instead)
-- locally (e.g. macOS) nvim auto-detects pbcopy/xclip, so leave it alone.
if vim.env.SSH_TTY or vim.env.SSH_CONNECTION then
  local osc52 = require "vim.ui.clipboard.osc52"
  local function paste()
    return { vim.fn.split(vim.fn.getreg "", "\n"), vim.fn.getregtype "" }
  end

  vim.g.clipboard = {
    name = "OSC 52",
    copy = { ["+"] = osc52.copy "+", ["*"] = osc52.copy "*" },
    paste = { ["+"] = paste, ["*"] = paste },
  }
end

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
