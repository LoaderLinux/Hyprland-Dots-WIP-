return {
  "uZer/pywal16.nvim",
  lazy = false, -- Load immediately
  priority = 1000, -- Ensure it's loaded early
  config = function()
    require("pywal16").setup()
    vim.cmd[[colorscheme pywal16]]
  end
}





















