{ ... }:

{
  imports = [ 
    ./boot.nix
    ./user.nix
    ./tty.nix
    ./rust.nix
    ./sound.nix
    ./foreigndevices.nix
    ./wayland.nix
    ./programs.nix

    ./services/auto-cleanup.nix
    ./services/printing.nix
  ];
}
