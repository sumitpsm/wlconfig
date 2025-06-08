{ ... }:

{
  imports = [ 
    ./boot.nix
    ./user.nix
    ./tty.nix
    ./rust.nix
    ./sound.nix
    ./usb.nix
    ./wayland.nix
    ./programs.nix

    ./services
  ];
}
