
{ config, inputs, lib, osConfig, ... }:
{
  imports = [
    inputs.vscode-server.homeModules.default
  ];
  config = lib.mkIf osConfig.mine.machine.asServer.enable {
    services.vscode-server = {
      enable = true;
      # enableFHS = true;
    };
  };
}