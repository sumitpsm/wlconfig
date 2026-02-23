{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fuzzel
    gnome-characters

    quickshell  # Required for QML runtime
    # go          # For building DMS components
    # cava        # Audio visualization
    # cliphist    # Clipboard history
    # ddcutil
    # qt6.qtmultimedia
    # accountsservice
    # matugen     # Dynamic theming
    # gpu-screen-recorder
    # wlsunset
    # xdg-desktop-portal
    # evolution-data-server
    # app2unit
    # lm-sensors
    # swappy
    # aubio
    # libqalculate
    # kdePackages.kcolorchooser

    # notification client [libnotify]
    # character menu [gnome-characters]
    # volume control [pavucontrol, playerctl]
    # screen-locking-utility [hyprlock]
    # ags/eww # widget system [statusbar, application-launcher, calender, notifications]
    # [waybar, rofi, swaynotificationcenter, networkmanagerapplet, wlogout, swappy]
    # yad zenity amfora appimage-run usbutils v4l-utils nwg-displays gnome-maps gnome-clocks
  ];
}
