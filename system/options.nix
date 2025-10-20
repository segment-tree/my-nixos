{ config, pkgs, lib, ...}:

{
  options = with lib; {
    mine.machine.name = mkOption {
      type = types.str;
      # default = "";
      description = "hostname";
    };
    mine.machine.isVM = mkOption {
      type = types.bool;
      default = false;
    };
    mine.machine.gaming-user.enable = mkOption {
      type = types.bool;
      default = false;
    };
    mine.machine.asServer.enable = mkOption {
      type = types.bool;
      default = false;
      description = "make this machine a server (ssh, vscode-ssh, user: server, etc .)";
    };
  };
}


