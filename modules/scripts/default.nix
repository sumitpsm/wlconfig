{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.symlinkJoin {
      name = "custom-scripts";
      paths = [
        # `import` should also work instead of `pkgs.callPackage`
        (pkgs.callPackage ./ascii.nix { inherit pkgs; })
        (pkgs.callPackage ./git-ls.nix { inherit pkgs; })
        (pkgs.callPackage ./gitc.nix { inherit pkgs; })
        (pkgs.callPackage ./rs.nix { inherit pkgs; })
        (pkgs.callPackage ./tscp.nix { inherit pkgs; })
        (pkgs.callPackage ./wset.nix { inherit pkgs; })
      ];
      meta = {
        description = "A collection of custom scripts";
      };
    })
  ];
}

