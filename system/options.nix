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
  };
}


