{ pkgs, lib, config, ... }:

{
  # this file is multiuser.
  # $homeMgr/tools/asahi-tools.nix for single user.
  environment.systemPackages = with pkgs; lib.mkIf config.mine.machine.isAsahi [
    asahi-btsync
    muvm
  ];
}
