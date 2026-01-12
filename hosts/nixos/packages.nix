{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # hyprlock
    fuzzel
    # ashell
    gnome-characters
    # libnotify
    grim slurp hyprpicker kdePackages.kcolorchooser

    quickshell  # Required for QML runtime
    go          # For building DMS components
    cava        # Audio visualization
    cliphist    # Clipboard history
    brightnessctl ddcutil
    qt6.qtmultimedia
    accountsservice
    matugen     # Dynamic theming
    gpu-screen-recorder
    wlsunset
    xdg-desktop-portal
    evolution-data-server
    app2unit
    # lm-sensors
    swappy
    aubio
    libqalculate

    # notification client [libnotify]
    # character menu [gnome-characters]
    # volume control [pavucontrol, playerctl]
    # screen-locking-utility [hyprlock]
    # ags/eww # widget system [statusbar, application-launcher, calender, notifications]
    # [waybar, rofi, swaynotificationcenter, networkmanagerapplet, wlogout, swappy, grim/slurp]
    # imagemagick
  ];
}
