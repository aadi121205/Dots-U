return {
  -- Silence "X is not exported from Y" pyright false-positives
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            pyright = { disableOrganizeImports = true },
            python = {
              analysis = {
                reportPrivateImportUsage = "none",
              },
            },
          },
        },
      },
    },
  },

  -- Python virtual environment selector (<leader>cv to pick venv)
  {
    "linux-cultist/venv-selector.nvim",
    opts = {
      search = {
        miniconda_opt_envs = {
          command = "fd 'bin/python$' /opt/miniconda3/envs --no-ignore-vcs --full-path --color never",
          type = "anaconda",
        },
        miniconda_opt_base = {
          command = "fd '/python$' /opt/miniconda3/bin --no-ignore-vcs --full-path --color never",
          type = "anaconda",
        },
      },
      options = {
        notify_user_on_venv_activation = true,
      },
    },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
  },

  -- Render ipynb as readable Python (percent format) instead of raw JSON
  {
    "GCBallesteros/jupytext.nvim",
    opts = {
      style = "hydrogen",
      output_extension = "auto",
      force_ft = "python",
    },
  },

  -- Jupyter notebook support (ipynb)
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "none"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
    end,
    keys = {
      { "<leader>mi", "<cmd>MoltenInit<cr>", desc = "Molten Init" },
      { "<leader>me", "<cmd>MoltenEvaluateOperator<cr>", desc = "Evaluate Operator", expr = true },
      { "<leader>ml", "<cmd>MoltenEvaluateLine<cr>", desc = "Evaluate Line" },
      { "<leader>mr", "<cmd>MoltenReevaluateCell<cr>", desc = "Re-evaluate Cell" },
      { "<leader>md", "<cmd>MoltenDelete<cr>", desc = "Delete Cell" },
      { "<leader>mo", "<cmd>MoltenShowOutput<cr>", desc = "Show Output" },
      { "<leader>mv", ":<C-u>MoltenEvaluateVisual<cr><esc>", mode = "v", desc = "Evaluate Visual" },
    },
  },

}
