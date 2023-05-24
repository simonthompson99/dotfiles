local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
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
        "yamlfmt",
        "yamllint",
      }
    }
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
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

  -- disable nvterm as it doesn't assume pipenv properly
  {
    "NvChad/nvterm",
    enabled = false
  },

  -- Language-specific repls
  {
		"hkupty/iron.nvim",
    cmd = {"IronRepl", "IronReplHere"},
			config = function()
        require("custom.configs.iron").setup()
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

  -- make sure the correct treesitter parsers are installed
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
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
      },
      indent = {
        enable = true,
        disable = {
          "python",
          "yaml",
        },
      },
    }
  }


  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

}

return plugins
