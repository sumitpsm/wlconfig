{
  description = "Nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kmonad = {
      url = "github:kmonad/kmonad?dir=nix&ref=dccd498de1ffbc221a3b95c29fb9ea70168673a6";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... } @inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    devToolsLib = import ./modules/dev-tools.nix { inherit pkgs inputs; };
  in
  {
    packages.${system}.dev-tools = devToolsLib.dev-tools;

    nixosConfigurations = nixpkgs.lib.genAttrs
    [
      "nixos"
      "nixstation"
    ] # do not change this manually
    (hostname: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; inherit (devToolsLib) devTools; system = "x86_64-linux"; };
      modules = [
        ./modules/configuration.nix
        ./hosts/${hostname} { networking.hostName = hostname; }
        inputs.kmonad.nixosModules.default
      ];
    });
  };
}
