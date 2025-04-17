{
  description = "My nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @args:
  {
    nixosConfigurations = {
      # x86_64-linux system
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit args; };
        modules = [ ./nixos/configuration.nix ];
      };
    };
  };
}
