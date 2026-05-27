{ pkgs, ... }:

{
  imports = [
    # ./gnome-network-displays.nix
    ./IOS.nix
    ./podman.nix
    ./asahi-tools.nix
    ./niri.nix
    ./ssh.nix
    ./sunshine.nix
    # ./dae.nix
    ./clash-verge.nix
  ];

  # programs.nix-ld.enable = true; # warning

  environment.systemPackages = with pkgs; [
    libheif # view heic files
    vim # editor
    git # flake
    wget
    trash-cli
    # neofetch
    fastfetch
    openssh
    htop
    # clash-meta
    gcc gdb

    btop
    util-linux
    libnotify localsend
    net-tools pciutils usbutils

    mission-center

    waypipe
  ];

  services.udev.packages = with pkgs; [
    probe-rs-tools stlink
  ];
}
