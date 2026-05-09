{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    papers # document viewer
    mpv mpvScripts.mpris # video & audio player
    obs-studio obs-cli # screen recorder
    gimp3 # image editor // [inkscape krita]
    # blender # 3d modelling system + video editor

    (inputs.zen-browser.packages.${stdenv.hostPlatform.system}.beta.override {}) # zen browser
    # kmonad # keyboard mapper
  ];
  # programs.calls.enable = true;
}
