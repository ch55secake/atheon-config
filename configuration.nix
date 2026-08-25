{ pkgs, ... }:

{
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.oscar = {
    name = "oscar";
    home = "/Users/oscar";
  };

  system.primaryUser = "oscar";

  environment.systemPackages = with pkgs; [
    vim
    curl
    wget
    jq
    ripgrep
    fd
  ];

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;

  homebrew = {
   enable = true;
   enableZshIntegration = true;

   taps = [
     "anomalyco/tap"
     "nikitabobko/tap"
   ];

   brews = [
     "anomalyco/tap/opencode"
   ];

   casks = [
     "ghostty"
     "pycharm"
     "intellij-idea"
     "nikitabobko/tap/aerospace"
   ];

   onActivation = {
     autoUpdate = true;
     upgrade = true;
     cleanup = "uninstall";
   };
 };  

  system.stateVersion = 6;
}
