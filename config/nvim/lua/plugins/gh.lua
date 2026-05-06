return {
  {
    "ldelossa/gh.nvim",
    dependencies = {
      {
        "ldelossa/litee.nvim",
        config = function()
          require("litee.lib").setup()
        end,
      },
    },
    config = function()
      require("litee.gh").setup({
        jump_to_reviewer = true,
        prefer_plaintext = false,
        icon_set = "default",
        map_resize_keys = false,
        disable_keymaps = false,
        gh_app_id = nil,
        -- pull panel on the right, code review panel below
        layout = "sidebar",
        keymaps = {
          open = "<CR>",
          expand = "zo",
          collapse = "zc",
          select = "<CR>",
          goto_issue = "gd",
          details = "d",
          toggle_viewed = "<leader><leader>",
          next_unviewed = "]u",
          prev_unviewed = "[u",
        },
      })
    end,
    keys = {
      { "<leader>Go", "<cmd>GHOpenPR<cr>",           desc = "Open PR" },
      { "<leader>Gc", "<cmd>GHClosePR<cr>",          desc = "Close PR" },
      { "<leader>Gp", "<cmd>GHPopOutPR<cr>",         desc = "PopOut PR" },
      { "<leader>Gm", "<cmd>GHMerge<cr>",            desc = "Merge PR" },
      { "<leader>Gs", "<cmd>GHSearchPRs<cr>",        desc = "Search PRs" },
      { "<leader>Gr", "<cmd>GHOpenToReview<cr>",     desc = "Open PR to Review" },
      { "<leader>Gf", "<cmd>GHPRFiles<cr>",          desc = "PR Files" },
      { "<leader>Gd", "<cmd>GHPRDetails<cr>",        desc = "PR Details" },
      { "<leader>Gi", "<cmd>GHOpenIssue<cr>",        desc = "Open Issue" },
      { "<leader>Gl", "<cmd>GHLogActivity<cr>",      desc = "Log Activity" },
      { "<leader>Ga", "<cmd>GHAddReviewer<cr>",      desc = "Add Reviewer" },
      { "<leader>Gx", "<cmd>GHRemoveReviewer<cr>",   desc = "Remove Reviewer" },
      { "<leader>GA", "<cmd>GHApproveReview<cr>",    desc = "Approve Review" },
      { "<leader>GS", "<cmd>GHSubmitReview<cr>",     desc = "Submit Review" },
    },
  },
}
