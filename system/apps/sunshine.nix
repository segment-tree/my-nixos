{ config, pkgs, lib, ... }:
lib.mkIf (config.mine.machine.softwares.uncommonSoftware.InstallLevel >= 5) {
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}