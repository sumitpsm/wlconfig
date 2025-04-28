{
  description = "Nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @inputs:
  {
    # x86_64-linux systems
    nixosConfigurations = nixpkgs.lib.genAttrs
    [ "nixos" "testconf" ] # <-- add hosts
    (hostname: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/configuration.nix
          ./nixos/hardware/${hostname}.nix { networking.hostName = hostname; }
        ];
    });
  };
}
