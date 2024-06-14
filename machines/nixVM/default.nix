{...}:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../system
    ];
    #custom settings are here:
    networking.hostName = "nixVM";
}
