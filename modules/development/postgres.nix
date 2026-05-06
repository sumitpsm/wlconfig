{ pkgs, lib, ... }:

{
  # environment.systemPackages = [ pkgs.pgadmin4 ];

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;
    enableTCPIP = true;
    settings = {
      port = 5432;
    };
  };
  systemd.services.postgresql.wantedBy = lib.mkForce [];
  systemd.targets.postgresql.wantedBy = lib.mkForce [];
}
