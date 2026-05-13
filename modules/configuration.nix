{ ... }:

{
  imports = [ 
    ./boot.nix
    ./daemons.nix
    ./monitoring.nix
    ./programs.nix
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
