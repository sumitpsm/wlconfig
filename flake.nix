{
  description = "Nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # kmonad = {
    #   url = "github:kmonad/kmonad?dir=nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
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
        # inputs.kmonad.nixosModules.default {
        #   services.kmonad = {
        #     enable = true;
        #     keyboards = {
        #       myKMonadOutput = {
        #         device = "/dev/input/by-path/pci-0000:01:00.0-usbv2-0:5:1.0-event-kbd";
        #         config = builtins.readFile /home/sumit/dev/colemaxx.kbd;
        #       };
        #     };
        #   };
        # }
      ];
    });
  };
}
