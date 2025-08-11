{inputs, pkgs, lib, ...}:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ../../system
    ];
  #custom settings are here:
  mine.machine.name = "9700X";
  # hardware.videoDrivers = [ "intel" ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ mesa ];
  };

  environment.systemPackages = with pkgs; [
    mesa
    vulkan-loader
    vulkan-tools
    # vulkan-intel
  ];
}
