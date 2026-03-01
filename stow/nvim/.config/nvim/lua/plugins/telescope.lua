return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<Leader>ff",
        function()
          require("telescope.builtin").git_files()
        end,
      },
      {
        "<Leader>fb",
        function()
          require("telescope.builtin").buffers()
        end,
      },
      {
        "<Leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
      },
      {
        "<Leader>fd",
        function()
          require("telescope.builtin").diagnostics()
        end,
      },
    },
  },
}
