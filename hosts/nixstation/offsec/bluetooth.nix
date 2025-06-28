{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    spooftooph
  ];
}
