{ pkgs, ... }:

{
  home.username = "oscar";
  home.homeDirectory = "/Users/oscar";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "ch55secake";
        email = "oscardjbackup@gmail.com";
      };

      init.defaultBranch = "main";

      pull.rebase = true;
    };
  };

  programs.home-manager.enable = true;

  programs.home-manager.enable = true;
}
