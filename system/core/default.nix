{ config, pkgs, pkgs-stable, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  
  #####
  #boot.kernelPackages= pkgs-stable.linuxPackages_zen;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  # nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"  "https://cache.nixos.org/" ];
  virtualisation = {
    vmware.guest.enable = true;
    vmware.guest.headless = true;#
    waydroid.enable = true;
    lxd.enable = true;
  };
}
