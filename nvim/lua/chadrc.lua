-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "github_dark",
  theme_toggle = { "github_dark", "github_light" },

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
}

M.nvdash = { load_on_startup = true }

M.ui = {
  cmp = {
    style = "default" -- default/flat_light/flat_dark/atom/atom_colored
  },

  telescope = { style = "bordered" }, -- borderless / bordered

  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
  }
--       tabufline = {
--          lazyload = false
--      }
}

return M
