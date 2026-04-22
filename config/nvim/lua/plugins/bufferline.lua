return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      separator_style = "slant",
      show_buffer_close_icons = true,
      show_close_icon = false,
      always_show_bufferline = true,
      sort_by = "directory",
      custom_filter = function(buf)
        local bt = vim.bo[buf].buftype
        -- only show normal file buffers
        if bt == "terminal" or bt == "nofile" or bt == "prompt" or bt == "quickfix" then
          return false
        end
        return true
      end,
    },
  },
}
