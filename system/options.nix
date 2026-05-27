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
    mine.machine.isAsahi = mkOption {
      type = types.bool;
      default = false;
      description = "whether this machine an Asahi (Apple Silicon) machine or not";
    };
    mine.machine.softwares.uncommonSoftware.InstallLevel = mkOption {
      type = types.ints.between 0 10;
      default = 10;
      description = "the level of uncommon software to be installed. The number is bigger, the more uncommon software will be installed. The level is defined by the user.";
    };
  };
}


