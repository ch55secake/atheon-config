{ pkgs, ... }:

{
  # Determinate manages the Nix installation/daemon.
  # Prevent nix-darwin from trying to manage it too.	  
  nix.enable = false;

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
}
