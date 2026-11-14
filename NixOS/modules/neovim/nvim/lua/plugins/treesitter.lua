-- lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local configs = require("nvim-treesitter.config")
    configs.setup({
      highlight = { enabled = true },
      indent = { enable = true },
      autotag = { enable = true },
      ensure_installed = {
        -- Core & Config
        "lua", "vim", "vimdoc", "query",
        -- Web / Markup / Data
        "html", "css", "javascript", "typescript", "json", "tsx",
        "bash", "dockerfile", "markdown", "markdown_inline", "toml", "yaml",
        -- Backend / Systems / Scripting
        "java", "sql", "c", "cmake", "cpp", "go", "make", "ninja", "rust",
        "python", "terraform", "hcl", "ruby", "zig", "haskell",
      },
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
