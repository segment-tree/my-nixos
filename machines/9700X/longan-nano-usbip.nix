{pkgs, config, lib, ...}:
let
  usbip = "${config.boot.kernelPackages.usbip}/bin/usbip";
  attachScript = pkgs.writeShellScriptBin "longan-nano-usbip-attach" ''
    host="100.65.233.28"
    last_busid=""
    last_failed_busid=""

    already_attached() {
      ${usbip} port 2>/dev/null | ${pkgs.gawk}/bin/awk -v host="$host" -v busid="$busid" '
        index($0, "(28e9:0189)") || index($0, "usbip://" host "/" busid) { found=1 }
        END { exit(found ? 0 : 1) }
      '
    }

    while :; do
      busid="$(${pkgs.coreutils}/bin/timeout 3s ${usbip} list -r "$host" 2>/dev/null | ${pkgs.gawk}/bin/awk 'index($0, "(28e9:0189)") && match($0, /^[[:space:]-]*([0-9][0-9A-Za-z.-]*):/, m) { print m[1]; exit }')"
      if [ -n "$busid" ] && [ "$busid" != "$last_busid" ]; then
        echo "longan-nano-usbip: found busid=$busid on $host"
        last_busid="$busid"
        last_failed_busid=""
      fi
      if [ -n "$busid" ] && ! already_attached; then
        if ! ${pkgs.coreutils}/bin/timeout 5s ${usbip} attach -r "$host" -b "$busid" >/dev/null 2>&1; then
          if [ "$busid" != "$last_failed_busid" ]; then
            echo "longan-nano-usbip: attach failed for busid=$busid"
            last_failed_busid="$busid"
          fi
        else
          last_failed_busid=""
        fi
      fi

      sleep 2
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
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${attachScript}/bin/longan-nano-usbip-attach";
      Restart = "always";
      RestartSec = 2;
    };
  };
}
