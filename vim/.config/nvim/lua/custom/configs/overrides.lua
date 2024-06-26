local M = {}

-- M.treesitter = {
--   ensure_installed = {
--     "vim",
--     "lua",
--     -- "html",
--     -- "css",
--     -- "javascript",
--     -- "c",
--     "markdown",
--     "markdown_inline",
--     "r",
--     "python",
--     "bash",
--     "yaml",
--   },
--   indent = {
--     enable = true,
--     disable = {
--       "python",
--       "yaml",
--     },
--   },
-- }

M.mason = {
  ensure_installed = {
    -- lua stuff
    -- "lua-language-server",
    -- "stylua",

    -- web dev stuff
    -- "css-lsp",
    -- "html-lsp",
    -- "typescript-language-server",
    -- "deno",
    -- "prettier"
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
