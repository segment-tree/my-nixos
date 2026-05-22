{ config, pkgs, ... }:

{
  environment.systemPackages = [
    config.boot.kernelPackages.usbip
    pkgs.usbutils
  ];

  boot.kernelModules = [
    "usbip_core"
    "usbip_host"
  ];

  networking.firewall.allowedTCPPorts = [ 3240 ];

  systemd.services.usbipd = {
    description = "USB/IP daemon";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      Type = "forking";
      PIDFile = "/run/usbipd.pid";
      ExecStart = "${config.boot.kernelPackages.usbip}/bin/usbipd -D -P /run/usbipd.pid";
      Restart = "on-failure";
    };
  };
}
