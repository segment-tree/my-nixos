{ config, pkgs, ... }:

{
  environment.systemPackages = [
    config.boot.kernelPackages.usbip
    pkgs.usbutils
    # pkgs.dfu-util
  ];

  boot.kernelModules = [
    "usbip_core"
    "vhci_hcd"
  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", TAG+="uaccess"
  '';
}