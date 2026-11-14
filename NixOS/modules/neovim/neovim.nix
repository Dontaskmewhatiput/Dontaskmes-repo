# /etc/nixos/modules/neovim/neovim.nix
{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    sideloadInitLua = true;

    extraConfig = ''
      set guifont=Ioskeley\ Mono\ Term:h14
    '';

    extraPackages = with pkgs; [
      # Treesitter parser builds
      gcc
      tree-sitter

      # LSP
      lua-language-server
      clang-tools                
      rust-analyzer
      gopls
      vscode-langservers-extracted   
      typescript-language-server
      nil                        
      bash-language-server
      dockerfile-language-server
      marksman
      yaml-language-server           
      sqls
      basedpyright
      ruff
      terraform-ls
      zls
      haskell-language-server
      templ
      jdt-language-server       

      # Debuggers (DAP)
      vscode-extensions.vadimcn.vscode-lldb.adapter 
      delve                                    
      (python3.withPackages (ps: [ ps.debugpy ]))

      # Linters and formatters
      luaPackages.luacheck
      checkstyle
      golangci-lint
      stylelint
      eslint_d
      statix
      shellcheck
      hadolint
      markdownlint-cli
      yamllint
      sqlfluff
      htmlhint
      tflint
    ];

    # Jar folders for nvim-jdtls bundles
    extraWrapperArgs = [
      "--set" "JAVA_DEBUG_DIR"
      "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server"
      "--set" "JAVA_TEST_DIR"
      "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server"
    ];
  };

  xdg.configFile."nvim".source = ./nvim;
}
