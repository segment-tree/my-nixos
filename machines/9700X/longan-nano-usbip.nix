{pkgs, config, lib, ...}:
let
  usbip = "${config.boot.kernelPackages.usbip}/bin/usbip";
  attachScript = pkgs.writeShellScriptBin "longan-nano-usbip-attach" ''
    host="100.65.233.28"

    while :; do
      busid="$(${usbip} list -r "$host" 2>/dev/null | ${pkgs.gawk}/bin/awk 'match($0, /^[[:space:]-]*([0-9][0-9A-Za-z.-]*):.*\\(28e9:0189\\)/, m) { print m[1]; exit }')"
      if [ -n "$busid" ] && ! ${usbip} port 2>/dev/null | ${pkgs.gnugrep}/bin/grep -q "$busid"; then
        ${usbip} attach -r "$host" -b "$busid" >/dev/null 2>&1 || true
      fi

      sleep 1
    done
  '';
in
{
  imports = [
    ../../system/apps/usbip.client.nix
  ];
   # USB permissions for Sipeed Longan Nano (GD32 DFU bootloader)
  services.udev.extraRules = lib.mkAfter ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="28e9", ATTR{idProduct}=="0189", MODE="0666"
  '';

  systemd.services.longan-nano-usbip-attach = {
    description = "Keep Longan Nano attached over USB/IP";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${attachScript}/bin/longan-nano-usbip-attach";
      Restart = "always";
      RestartSec = 2;
    };
  };
}
