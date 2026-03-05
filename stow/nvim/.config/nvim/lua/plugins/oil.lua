return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      view_options = {
        show_hidden = true,
      },
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
    },
    keys = {
      { "-", "<CMD>Oil<CR>" },
    },
  },
}
