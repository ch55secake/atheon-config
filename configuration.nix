{ pkgs, ... }:

{
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.oscar = {
    name = "oscar";
    home = "/Users/oscar";
  };

  system.primaryUser = "oscar";

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  system.defaults = {
    NSGlobalDomain = {
      AppleICUForce24HourTime = false;
      "com.apple.swipescrolldirection" = false;

      AppleWindowTabbingMode = "always";
    };

    dock = {
      autohide = true;
      show-recents = false;
      mru-spaces = false;
    };
  };

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
     "btop"
     "bat"
     "gh"
     "herdr"
     "hx"
     "fzf"
   ];

   casks = [
     "ghostty"
     "pycharm"
     "goland"
     "nikitabobko/tap/aerospace"
     "tailscale-app"
   ];

   onActivation = {
     autoUpdate = true;
     upgrade = true;
     cleanup = "uninstall";
   };
 };  

  system.stateVersion = 6;
}
