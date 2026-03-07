{ inputs, lib, config, pkgs, ... }:


{
  # this file is multiuser.
  # $homeMgr/app/niri/* for single user.
  imports = [
    # inputs.niri.nixosModules.niri

    # inputs.niri-session-manager.nixosModules.niri-session-manager
  ];
  # nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri.enable = true;
  programs.niri.useNautilus = true;
  environment.systemPackages = with pkgs; [
    alacritty
    fuzzel
    xwayland-satellite
  ];
  services.dbus.implementation = "broker";
  systemd.user.services.niri-flake-polkit.serviceConfig.ExecStart =
    lib.mkForce "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
}
