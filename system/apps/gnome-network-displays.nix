# NOT WORK!
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnome-network-displays
    xdg-dbus-proxy
  ];
  xdg.portal.enable = true;

  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.extraPortals = [
    #pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-gnome
    pkgs.xdg-desktop-portal-wlr
  ];
}
     
