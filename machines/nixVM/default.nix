{...}:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../system
    ];
  #custom settings are here:
  networking.hostName = "nixVM";
  
  virtualisation = {
    vmware.guest.enable = true;
    vmware.guest.headless = true;#
    waydroid.enable = true;
    lxd.enable = true;
  };
  
  services.keyd.keyboards.default = {
    extraConfig = ''
      [main]
      leftmeta=layer(control)
      leftcontrol=layer(meta)
    '';
  };
}
