{ pkgs, ... }:

{
  imports = [
    ./gnome-network-displays.nix
    ./IOS.nix
    ./podman.nix
    ./asahi-tools.nix
    ./niri.nix
    ./ssh.nix
  ];

  # programs.nix-ld.enable = true; # warning

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
    btop
    util-linux
    net-tools
  ];
}
