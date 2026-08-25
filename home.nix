{ pkgs, ... }:

{
  home.username = "oscar";
  home.homeDirectory = "/Users/oscar";
  home.stateVersion = "26.05";

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

  programs.zsh = {
    enable = true;

    shellAliases = {
      rebuild = "sudo nix run github:nix-darwin/nix-darwin#darwin-rebuild -- switch --flake ~/Projects/atheon-config";
    };
  };

  programs.home-manager.enable = true;
}
