{ config, pkgs, lib, nur, pkgs-stable, ... }:

{
  home.username = "gaming";
  home.homeDirectory = "/home/gaming";
  
  imports = [
  ];
 
  home.packages = with pkgs;[
    firefox-wayland
    # steam
    # wine
    # proton
  ];
  
  xdg.enable = true;
  
  dconf.settings = {
    "org/gnome/desktop/interface".scaling-factor = lib.hm.gvariant.mkUint32 2;
    "org/gnome/SessionManager".auto-save-session = true; # NOT WORK
    "org/gnome/desktop/interface".text-scaling-factor = 1.03125; # 1.0625;
    # DELETE: dconf reset -f  "/org/gnome/shell/extensions/gsconnect/"
    # MODIFY: gsettings set org.gnome.desktop.interface text-scaling-factor 1.1875
  };
  
  # programs.steam = {
  #   enable = true;
  # };

  
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
