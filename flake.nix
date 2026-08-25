{
  description = "macOs machine config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, ... }:
    let
      configuration = { pkgs, ... }: {
        imports = [
          ./configuration.nix
        ];

        # Required for backwards compatibility.
        system.stateVersion = 6;

        # Platform for Apple Silicon Macs.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in
    {
      darwinConfigurations."atheon" =
        nix-darwin.lib.darwinSystem {
          modules = [ configuration ];
        };
    };
}
