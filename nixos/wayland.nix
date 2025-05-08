{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # displayManager.gdm.enable = true;
    # desktopManager.gnome.enable = true;
    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      kmonad # keyboard mapper
      libnotify # notification client
      wl-clipboard # clipboard manager
      brightnessctl
      swww # wallpaper
      hypridle # idling utility
      imagemagick wallust # theme

      # screen-locking-utility [hyprlock]
      # ags/eww # widget system [statusbar, application-launcher, calender, notifications]
      # screen-shotting-tool & color-picker
      # waybar, rofi, swaynotificationcenter, networkmanagerapplet, wlogout, swappy, grim/slurp

      kitty brave obs-studio gimp handbrake gnome-characters
      nautilus loupe mpv zathura
      virt-manager wireshark
      # calls dia gnome-boxes gnome-maps

      # pipes cmatrix
    ];
    variables = {
      TERMINAL = "kitty";
    };
  };

  programs = {
    firefox.enable = false;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    bash.shellAliases = {
      icat = "kitty +kitten icat";
      kmap = "sudo kmonad ~/dev/colemak-sumit.kbd";
    };
  };

  services.hypridle.enable = true;

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #   # xdg-open
  #   # xdg-user-dirs
  #   # xdg-utils
  # };
}
