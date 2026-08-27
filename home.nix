{ pkgs, ... }:

{
  home.username = "oscar";
  home.homeDirectory = "/Users/oscar";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
  	just
        go 
        gopls 
        python3
        uv
  ];

  home.file = {
    # Silence the macOS login message
    ".hushlogin".text = "";

    # SSH keys trusted for Git signature verification
    ".config/git/allowed_signers".text = ''
      oscardjbackup@gmail.com ${builtins.readFile ./keys/oscar.pub}
    '';
  };

  programs.git = {
   enable = true;

   settings = {
     user = {
       name = "ch55secake";
       email = "oscardjbackup@gmail.com";
     };

     init.defaultBranch = "main";
     pull.rebase = true;

     gpg.ssh.allowedSignersFile =
      "/Users/oscar/.config/git/allowed_signers";
   };

    signing = {
      key = "/Users/oscar/.ssh/id_ed25519.pub";
      format = "ssh";
      signByDefault = true;
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
     gch = "git checkout";
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

  xdg.configFile = {
    "ghostty/config".source = ./config/ghostty/config;
    "aerospace/aerospace.toml".source = ./config/aerospace/aerospace.toml;
  }; 

  programs.home-manager.enable = true;
}
