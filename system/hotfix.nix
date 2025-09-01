{inputs, pkgs, lib, ...}:

{
  #temp: !
  nixpkgs.config.permittedInsecurePackages = [
    "libsoup-2.74.3"
  ];
}