{ ... }:

{
  imports = [ 
    ./containerization.nix
    ./dev.nix
    ./misc.nix
    ./postgres.nix
    ./virtualisation.nix
  ];
}
