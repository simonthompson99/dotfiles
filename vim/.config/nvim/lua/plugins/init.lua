return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

    -- Vim/TMUX Navigation
  { 'alexghergh/nvim-tmux-navigation',
    lazy = false,
    config = function()
      require'nvim-tmux-navigation'.setup {
        -- disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          last_active = "<C-\\>",
          next = "<C-Space>",
        }
      }
    end
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
  	"williamboman/mason.nvim",
  	opts = {
  		ensure_installed = {
        "pyright",
        "python-lsp-server",
        "r-languageserver",
        "lua-language-server",
        "prettier",
        "terraform-ls",
        "tflint",
        "yamlfmt",
        "yamllint",
  		},
  	},
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
        "bash",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "r",
        "terraform",
        "vim",
        "yaml",
        "hcl",
  		},
  	},
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local conf = require "nvchad.configs.telescope"

      return conf
    end,
  },

    -- disable nvterm as it doesn't assume pipenv properly
  {
    "NvChad/nvterm",
    enabled = false
  },

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("configs.nvim-tree").setup()
    end
  },

  -- Language-specific repls
  {
		"hkupty/iron.nvim",
    cmd = {"IronRepl", "IronReplHere"},
			config = function()
        require("configs.iron").setup()
      end
		--config = require("config.iron"),
	},

  -- Get a terminal that assumes pipenv properly
  {
		"akinsho/toggleterm.nvim",
		tag = '2.4.0',
    cmd = {"ToggleTerm"},
		config = function()
      require("toggleterm").setup()
    end
  },


}
