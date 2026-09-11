return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden",
      },
      file_ignore_patterns = {
        ".git",
      },
    },
  },
}
