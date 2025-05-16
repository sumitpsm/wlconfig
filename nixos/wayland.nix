{ config, pkgs, ... }:

# let
#   BibataHyprCursorTheme = builtins.fetchTarball {
#     url = "https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Original-Classic-Right.tar.xz";
#     sha256 = "0g8b619f07659z4jy7xzxf8m7c6bl68fm1abcaii15sxsz11n7i4";
#   };
# in
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
      # (pkgs.runCommand "Bibata-Original-Classic-Right" {} ''
      #   mkdir -p $HOME/.local/share/icons
      #   ln -s ${BibataHyprCursorTheme} $HOME/.local/share/icons/Bibata-Original-Classic-Right
      # '')

      # gtk-themes

      libnotify # notification client
      # pavucontrol, playerctl
      # screen-locking-utility [hyprlock]
      # ags/eww # widget system [statusbar, application-launcher, calender, notifications]
      # screen-shotting-tool & color-picker
      # waybar, rofi, swaynotificationcenter, networkmanagerapplet, wlogout, swappy, grim/slurp
    ];
  };

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
