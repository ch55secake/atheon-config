{ pkgs, ... }:

{
  # Determinate manages the Nix installation/daemon.
  # Prevent nix-darwin from trying to manage it too.	  
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.oscar = {
   name = "oscar";
   home = "/Users/oscar";
  };

  system.primaryUser = "oscar";

  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    wget
    jq
    ripgrep
    fd
  ];

  programs.zsh.enable = true;

  # Lets nix-darwin manage itself.
  programs.zsh.enableCompletion = true;
  
  system.stateVersion = 6;
}
