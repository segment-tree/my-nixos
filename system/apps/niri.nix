{ inputs, lib, config, pkgs, ... }:


{
  # this file is multiuser.
  # $homeMgr/app/niri/* for single user.
  imports = [ inputs.niri.nixosModules.niri ];
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [
    alacritty
    fuzzel
  ];
  
}
