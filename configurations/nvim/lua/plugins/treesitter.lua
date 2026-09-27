return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local configs = require("nvim-treesitter.config")
    configs.setup ({
      highlight = {
        enabled = true 
      },
      indent = { enable = true },
      autotage = { enable = true },
    })
    ensure_installed = {
      "lua", "vim", "vimdoc", "query",
      "html", "css", "javascript", "typescript", "json", "tsx",
      "bash", "dockerfile", "markdown", "markdown_inline", "toml", "yaml",
      "java", "sql",
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
