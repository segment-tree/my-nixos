{ pkgs, ... }:
{
  services.kdeconnect = {
    enable = true;
    package = pkgs.valent;
  };
  # home.packages = [pkgs.gnomeExtensions.valent]; # NOT WORK AT ALL
}
