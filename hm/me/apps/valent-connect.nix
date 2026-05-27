{ pkgs, osConfig, lib, ... }:
lib.mkIf (osConfig.mine.machine.softwares.uncommonSoftware.InstallLevel >= 8)
{
  services.kdeconnect = {
    enable = true;
    package = pkgs.valent;
  };
  # home.packages = [pkgs.gnomeExtensions.valent]; # NOT WORK AT ALL
}
