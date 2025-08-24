{
  description = "Nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # rust-overlay = {
    #   url = "github:oxalica/rust-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... } @inputs:
  {
    nixosConfigurations = nixpkgs.lib.genAttrs
    [
      "nixos"
      "nixstation"
    ] # do not change this manually
    (hostname: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; system = "x86_64-linux"; };
      modules = [
        ./modules/configuration.nix
        ./hosts/${hostname} { networking.hostName = hostname; }
      ];
    });
  };
}
