-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function toggle_bottom_terminal()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      if not vim.api.nvim_buf_get_name(buf):match("claude") then
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_buf(win) == buf then
            vim.api.nvim_win_close(win, false)
            return
          end
        end
        vim.cmd("botright 20split")
        vim.api.nvim_win_set_buf(0, buf)
        vim.cmd("startinsert")
        return
      end
    end
  end
  vim.cmd("botright 20split")
  vim.cmd("terminal")
end

vim.keymap.set({ "n", "t" }, "<C-/>", toggle_bottom_terminal, { desc = "Toggle bottom terminal" })
