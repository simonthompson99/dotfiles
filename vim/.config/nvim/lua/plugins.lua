local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Colorscheme
    use {
      "arcticicestudio/nord-vim",
      config = function()
        vim.cmd "colorscheme nord"
      end,
    }

    -- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    -- GPS to show where we are
    use {
        "SmiteshP/nvim-gps",
        requires = "nvim-treesitter/nvim-treesitter",
        module = "nvim-gps",
        config = function()
            require("nvim-gps").setup()
        end,
    }

    -- treesitter
    use {
  "nvim-treesitter/nvim-treesitter",
--   run = ":TSUpdate",
   config = function()
     require("config.treesitter").setup()
   end,
		requires = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
  },

}
		
		-- completiono
use {
  "ms-jpq/coq_nvim",
  branch = "coq",
  event = "InsertEnter",
  opt = true,
  run = ":COQdeps",
  config = function()
    require("config.coq").setup()
  end,
  disable = false,
}

		-- LSP
		-- LSP
--use {
--  "neovim/nvim-lspconfig",
--  opt = true,
--  event = "BufReadPre",
--  wants = { "nvim-lsp-installer", "coq_nvim" },
--  config = function()
--    require("config.lsp").setup()
--  end,
--  requires = {
--    "williamboman/nvim-lsp-installer",
--  },
--}
use {
    "williamboman/nvim-lsp-installer",
    {
        "neovim/nvim-lspconfig",
					config = function()
            require("nvim-lsp-installer").setup {}
            local lspconfig = require("lspconfig")
       --     lspconfig.sumneko_lua.setup {}
       --     lspconfig.pyright.setup {}
						lspconfig.pylsp.setup {}
						lspconfig.r_language_server.setup {}
				end
    }
}


-- send lines to the terminal
	-- use { "kassio/neoterm" }
	use {
		"hkupty/iron.nvim",
			config = function()
        require("config.iron").setup()
      end
		--config = require("config.iron"),
	}

    -- status line
    use {
      "nvim-lualine/lualine.nvim",
      config = function()
				require('config.lualine').setup()
			end,
      requires = { "nvim-web-devicons", "nvim-gps"} ,
    }

		-- fuzzy file finder
		use {
		 "ibhagwan/fzf-lua",
			requires = { "kyazdani42/nvim-web-devicons" },
		}

    -- Vimwiki
    use {
      "vimwiki/vimwiki",
			config = function()
        require("config.vimwiki").setup()
      end
    }

    -- Vim/TMUX Navigation
    use { "christoomey/vim-tmux-navigator" }

    -- Whichkey
    use {
      "folke/which-key.nvim",
      config = function()
        require("config.whichkey").setup()
      end,
    }

    -- Indent guides
    use { "lukas-reineke/indent-blankline.nvim" }

		-- automatic pairs
		--use { "jiangmiao/auto-pairs" }
		use { "windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup{}
			end,
		}

		-- toggle commenting
		use {
			"numToStr/Comment.nvim",
			config = function()
        require("Comment").setup()
			end
		}

		-- distraction-free writing
		use {
			"junegunn/goyo.vim"
		}

		-- better movements
		use {
			"ggandor/leap.nvim",
			config = function()
        require('leap').set_default_keymaps()
			end
		}


		-- Better Netrw
		use {"tpope/vim-vinegar"}

		-- get Lazygit in neovim
		use { "kdheepak/lazygit.nvim"}

		-- nice file explorer tree
		use {
		 "kyazdani42/nvim-tree.lua",
		 requires = {
			 "kyazdani42/nvim-web-devicons",
		 },
		 cmd = { "NvimTreeToggle", "NvimTreeClose" },
			 config = function()
				 require("config.nvimtree").setup()
			 end,
		}


    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
