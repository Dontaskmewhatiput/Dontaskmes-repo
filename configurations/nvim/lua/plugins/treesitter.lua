return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  init = function()
    local ensure_installed = {
      -- Neovim programming
      "lua", "vim", "vimdoc", "query",
      -- Web development
      "html", "css", "javascript", "typescript", "json", "tsx",
      -- Scripting and development
      "bash", "dockerfile", "markdown", "markdown_inline", "toml", "yaml",
      -- JVM & Backend
      "java", "sql",
      -- Systems and compiled
      "c", "cmake", "cpp", "go", "make", "ninja", "rust",
    }
    local installed = require("nvim-treesitter.config").get_installed()
    local to_install = vim.iter(ensure_installed)
      :filter(function(p) return not vim.tbl_contains(installed, p) end)
      :totable()
    if #to_install > 0 then
      require("nvim-treesitter").install(to_install)
    end

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
