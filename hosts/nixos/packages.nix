{ pkgs, ... }:

{
  # services.xserver.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [
    hyprlock
    fuzzel
    ashell
    gnome-characters
    libnotify

    # notification client [libnotify]
    # character menu [gnome-characters]
    # volume control [pavucontrol, playerctl]
    # screen-locking-utility [hyprlock]
    # ags/eww # widget system [statusbar, application-launcher, calender, notifications]
    # [waybar, rofi, swaynotificationcenter, networkmanagerapplet, wlogout, swappy, grim/slurp]
    # imagemagick
  ];
  programs = {
    bash.shellAliases = {
      kmap = "eval $(sudo kmonad ~/dev/colemaxx.kbd)";
    };
  };
}
