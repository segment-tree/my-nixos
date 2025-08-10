{inputs, pkgs, lib, ...}:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ../../system
    ];
  #custom settings are here:
  mine.machine.name = "9700X";
  
}
