-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function set_transparent()
  local groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "FloatBorder",
    "SignColumn",
    "StatusLine",
    "StatusLineNC",
    "TabLine",
    "TabLineFill",
    "TabLineSel",
    "EndOfBuffer",
    "LineNr",
    "CursorLineNr",
  }
  for _, g in ipairs(groups) do
    vim.api.nvim_set_hl(0, g, { bg = "NONE", ctermbg = "NONE" })
  end
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#38bdf8", bg = "NONE" })
end

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  pattern = "*",
  callback = set_transparent,
})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.winbar = ""
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
      vim.opt.guicursor = "a:ver25"
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  once = true,
  callback = function()
    vim.schedule(function()
      pcall(vim.cmd, "ClaudeCode")
      vim.defer_fn(function()
        vim.cmd("botright 20split")
        vim.cmd("terminal")
        vim.cmd("wincmd k")
      end, 500)
    end)
  end,
})
