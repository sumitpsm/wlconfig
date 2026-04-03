{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dive
    nerdctl
    podman-compose
    docker-compose
  ];

  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
    extraPackages = [ 
      pkgs.crun
      pkgs.runc
      pkgs.kata-runtime
    ];
  };
  
  users.users.${config.user.name}.extraGroups = ["docker"];
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      runtimes = {
        crun = { path = "${pkgs.crun}/bin/crun"; };
        kata = { path = "${pkgs.kata-runtime}/bin/kata-runtime"; };
      };
    };
  };
}
