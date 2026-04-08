{ config, pkgs, lib, nur, pkgs-stable, ... }:

{
  home.username = "server";
  home.homeDirectory = "/home/server";
  
  imports = [
  ];
 
  home.packages = with pkgs;[
    firefox
  ];
  
  xdg.enable = true;
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  
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
