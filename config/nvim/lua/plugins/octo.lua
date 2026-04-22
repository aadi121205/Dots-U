return {
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    submodules = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      enable_builtin = true,
      default_to_projects_v2 = true,
      default_merge_method = "squash",
      picker = "telescope",
    },
    keys = {
      { "<leader>gi", "<cmd>Octo issue list<cr>", desc = "GitHub Issues" },
      { "<leader>gp", "<cmd>Octo pr list<cr>", desc = "GitHub PRs" },
      { "<leader>gr", "<cmd>Octo repo view<cr>", desc = "GitHub Repo" },
      { "<leader>gS", "<cmd>Octo search<cr>", desc = "GitHub Search" },
    },
  },
}
