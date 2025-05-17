{ config, pkgs, ... }:

let
  NotwaitaBlackCursorTheme = builtins.fetchTarball {
    url = "https://github.com/ful1e5/notwaita-cursor/releases/download/v1.0.0-alpha1/Notwaita-Black.tar.xz";
    sha256 = "0byiix6pda7ibjpc1an1lrnm19prjmqx1q72ipx5q7dijw5z9fk4";
  };
in
{
  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      kmonad # keyboard mapper
      wl-clipboard # clipboard manager
      brightnessctl
      swww # wallpaper
      hypridle # idling utility
      imagemagick wallust # theme

      # hyprcursor-themes
      (pkgs.runCommand "Notwaita-Black" {} ''
        mkdir -p $out/share/icons
        ln -s ${NotwaitaBlackCursorTheme} $out/share/icons/Notwaita-Black
      '')

      # gtk-themes
      andromeda-gtk-theme
      nordzy-icon-theme

      libnotify # notification client
      # pavucontrol, playerctl
      # screen-locking-utility [hyprlock]
      # ags/eww # widget system [statusbar, application-launcher, calender, notifications]
      # screen-shotting-tool & color-picker
      # waybar, rofi, swaynotificationcenter, networkmanagerapplet, wlogout, swappy, grim/slurp
    ];
  };

  # Restores terminal sequence colors
  environment.etc."bash.bashrc".text = ''
  [ -f ~/.cache/wallust/sequences ] && (cat ~/.cache/wallust/sequences &)
  '';

  services.hypridle.enable = true;

  services.xserver = {
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #   # xdg-open
  #   # xdg-user-dirs
  #   # xdg-utils
  # };
}
