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

     # Navigation
     ".." = "cd ..";
     "..." = "cd ../..";

     # Git
     gst = "git status";
     ga = "git add";
     gc = "git commit";
     gp = "git push";
     gl = "git pull";
     gd = "git diff";
     gco = "git checkout";
     gb = "git branch";
    
     nr = "nix run";
     update = "cd ~/Projects/atheon-config && nix flake update && rebuild";

     # Better defaults
     grep = "grep --color=auto";
     ll = "ls -lah";

     # Nix config
     nixconfig = "cd ~/Projects/atheon-config";
   };
 }; 

  programs.home-manager.enable = true;
}
