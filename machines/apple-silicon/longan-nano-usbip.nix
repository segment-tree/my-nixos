{pkgs, config, lib, ...}:
let
  usbip = "${config.boot.kernelPackages.usbip}/bin/usbip";
  bindScript = pkgs.writeShellScriptBin "longan-nano-usbip-bind" ''
    busid="$1"
    [ -n "$busid" ] || exit 0
    ${usbip} bind -b "$busid" >/dev/null 2>&1 || true
  '';
in
{
  imports = [
    ../../system/apps/usbip.server.nix
  ];
   # USB permissions for Sipeed Longan Nano (GD32 DFU bootloader)
  services.udev.extraRules = lib.mkAfter ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="28e9", ATTR{idProduct}=="0189", MODE="0666"
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="28e9", ATTR{idProduct}=="0189", RUN+="${bindScript}/bin/longan-nano-usbip-bind %k"
  '';
}
