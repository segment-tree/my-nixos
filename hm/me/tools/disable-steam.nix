{ pkgs, lib, ... }:

{
  home.file.".local/share/applications/steam.desktop".text = ''
    [Desktop Entry]
    Name=Steam
    NoDisplay=true
  '';
 home.packages = [
   (pkgs.writeShellScriptBin "steam" ''
     echo "steam is disabled for current user"
   '')
 ];
}
