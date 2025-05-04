{ pkgs, ... }:

{
  # this file is multiuser.
  # $homeMgr/tools/asahi-tools.nix for single user.
  environment.systemPackages = with pkgs; [
    asahi-btsync
  ];
}
