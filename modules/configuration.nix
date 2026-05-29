{ ... }:

{
  imports = [ 
    ./audit.nix
    ./boot.nix
    ./daemons.nix
    ./disabled.nix
    ./sound.nix
    ./user.nix
    ./utilities.nix
    ./wayland.nix

    ./development
    ./devices
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.sudo.enable = false;
  security.sudo-rs = {
    enable = true;
    wheelNeedsPassword = true;
    execWheelOnly = true;   
    extraConfig = ''
      Defaults !pwfeedback
    '';
  };
}
