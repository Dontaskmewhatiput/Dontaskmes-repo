{ ... }:
{
  programs.git = {

    enable = true;

    settings = {
      user.name = "Marco Liang";
      user.email = "MarcoLiang@celestrix.org";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "nvim";
      rebase.autoStash = true;
    };
    
    signing = {
      format = "ssh";
      key = "~/.ssh/id_github.pub";
      signByDefault = true;
    };

    ignores = [
      "result"
      ".direnv/"
      "*.swp"
      "*~"
    ];
  };

  programs.gh.enable = true;

}
