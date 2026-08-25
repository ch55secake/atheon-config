{ pkgs, ... }:

{
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
