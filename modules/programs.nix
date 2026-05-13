{ inputs, pkgs, ... }:

{
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    papers # document viewer
    mpv mpvScripts.mpris # video & audio player
    obs-studio obs-cli # screen recorder
    gimp3 # image editor // [inkscape krita]
    # 3d modelling system + video editor // [blender kdenlive]

    (inputs.zen-browser.packages.${stdenv.hostPlatform.system}.beta.override {}) # zen browser
    # kmonad # keyboard mapper
  ];
}
