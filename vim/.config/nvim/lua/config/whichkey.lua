local M = {}

function M.setup()
  local whichkey = require "which-key"

  local conf = {
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
  }

  local opts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local mappings = {
		["lg"] = { "<cmd>LazyGit<CR>", "Lazygit" },
		["gy"] = { "<cmd>Goyo<CR>", "Goyo" },

    b = {
      name = "Buffer",
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    },

		f = {
			name = "Find",
			f = { "<cmd>FzfLua files<cr>", "Files" },
			b = { "<cmd>FzfLua buffers<cr>", "Buffers" },
			g = { "<cmd>FzfLua live_grep<cr>", "Live grep" },
			c = { "<cmd>FzfLua commands<cr>", "Commands" },
			e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
		},

    z = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    w = {
      name = "Vimwiki",
      w = { "<cmd>VimwikiIndex<CR>", "Wiki Index" },
      i = { "<cmd>VimwikiMakeDiaryNote<CR>", "Today" },
    },

		t = {
			name = "Terminal",
			z = { "<cmd>vsp<CR><cmd>terminal<CR>", "Start zsh terminal" },
			t = { "<cmd>vsp<CR><cmd>IronReplHere<CR>", "Start REPL" },
			l = { "<cmd>SendLineToREPL<CR>", "Send Line"},
			p = { "<cmd>SendParagraphToREPL<CR>", "Send paragraph"},
			f = { "<cmd>SendFunctionToREPL<CR>", "Send function"},
			x = { "<cmd>CloseREPL<CR>", "Close REPL"},
		},
		y = {
			name = "Yank",
			f = {"<cmd>YankFilename<CR>", "Yank filename" },
			d = {"<cmd>YankDirectory<CR>", "Yank directory" },
			p = {"<cmd>YankAbsolutePath<CR>", "Yank path" },
			r = {"<cmd>YankRelativePath<CR>", "Yank relative path" },
		},
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)

	local v_mappings = {

		t = {
			name = "Terminal",
			s = { "<cmd>SendSelectionToREPL<CR>", "Send selection" },
		},
		y = {
			name = "Yank",
			y = {"<Esc><cmd>YankSelectionToSystemReg<CR>", "Yank to system clipboard" },
		},
	}

	whichkey.register(v_mappings, {
		mode = "v",
		prefix = "<leader>"}
	)

end

return M
