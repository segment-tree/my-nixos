# warning: not capable with dae.

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, inputs, lib, ... }:

{
    programs.clash-verge = {
        enable = true;
        autoStart = true;
        serviceMode = true;
        tunMode = true;
    };

    # empty proxy on 7890 & 7891; for capability
    services.sing-box = {
        enable = true;

        settings = {
        log = {
            level = "warn";
        };

        inbounds = [
            {
            type = "http";
            tag = "http-direct";
            listen = "127.0.0.1";
            listen_port = 7890;
            }
            {
            type = "socks";
            tag = "socks-direct";
            listen = "127.0.0.1";
            listen_port = 7891;
            }
        ];

        outbounds = [
            {
            type = "direct";
            tag = "direct";
            }
        ];

        route = {
            final = "direct";
        };
        };
  };
}
