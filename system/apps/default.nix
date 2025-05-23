{ pkgs, ... }:

{
  imports = [
    ./gnome-network-displays.nix
    ./IOS.nix
    ./podman.nix
    ./asahi-tools.nix
    ./niri.nix
  ];
  environment.systemPackages = with pkgs; [
    libheif # view heic files
    vim # editor
    git # flake
    wget
    trash-cli
    neofetch
    openssh
    htop
    clash-meta
    gcc gdb
  ];
}
