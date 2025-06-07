{ config, pkgs, ... }:

let
  TuiGreetTheme = "\"border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=grey;input=red\"";
in
{
  # TUI login manager (greetd.tuigreet)
  services.greetd = {
    enable = true;
    vt = 3;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --theme ${TuiGreetTheme} --cmd Hyprland";
      };
    };
  };
}
