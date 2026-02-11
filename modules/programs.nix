{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zathura # document viewer
    mpv mpvScripts.mpris # video & audio player
    gnome-boxes # virtual machine manager
    gnome-calculator # calculator
    obs-studio # screen recorder
    gimp3 # image editor // [inkscape krita]
    blender # 3d modelling system + video editor

    (inputs.zen-browser.packages.${stdenv.hostPlatform.system}.beta.override {}) # zen browser
    # diagram editor // [drawy, rnote]
    # handbrake # video compressor
    # kmonad # keyboard mapper
  ];
  # programs.calls.enable = true;
}
