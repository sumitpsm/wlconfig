{
  description = "Nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @inputs:
  {
    # x86_64-linux systems
    nixosConfigurations = nixpkgs.lib.genAttrs
    [
      "nixos"
      "testconf"
    ] # do not change this manually
    (hostname: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./nixos/configuration.nix
        ./hosts/${hostname} { networking.hostName = hostname; }
      ];
    });
  };
}
