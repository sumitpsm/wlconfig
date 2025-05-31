{ config, pkgs, ... }:

{
  services.xserver.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [
    hyprlock
    grim
    slurp
    fuzzel
    ashell
    pavucontrol
    gnome-characters
    libnotify

    # notification client [libnotify]
    # character menu [gnome-characters]
    # volume control [pavucontrol, playerctl]
    # screen-locking-utility [hyprlock]
    # ags/eww # widget system [statusbar, application-launcher, calender, notifications]
    # screen-shotting-tool & color-picker
    # [waybar, rofi, swaynotificationcenter, networkmanagerapplet, wlogout, swappy, grim/slurp]
    # imagemagick
  ];
  programs = {
    bash.shellAliases = {
      kmap = "eval $(sudo kmonad ~/dev/colemaxx.kbd)";
    };
  };
}
