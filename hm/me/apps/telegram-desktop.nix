# telegram
# var location : .var/app/telegram/data
{ pkgs, ... }:
{
  home.packages = [
    (let
      _app = pkgs.telegram-desktop;
      packages = with pkgs; [
          telegram-desktop
      ];
    in pkgs.runCommand "telegram-desktop" {
      # Dependencies that should exist in the runtime environment
      buildInputs = packages;
      # Dependencies that should only exist in the build environment
      nativeBuildInputs = [ pkgs.makeWrapper ];
    } ''
      binNM=telegram-desktop
      dskNM=org.telegram.desktop.desktop
      VHOME=telegram
      
      mkdir -p $out/bin/
      echo ". /etc/nixos/hm/me/tools/vhome.sh; \
          vhome $VHOME ${_app}/bin/$binNM _" > $out/bin/$binNM
      chmod +x $out/bin/$binNM
      
      mkdir -p  $out/share/applications/
      cp -r ${_app}/share/applications/$dskNM \
         $out/share/applications/$dskNM
      sed -i "s|${_app}|$out|g" $out/share/applications/$dskNM
      sed -i "s|TryExec=telegram-desktop||g" $out/share/applications/$dskNM
      sed -i "s|DBusActivatable=true||g" $out/share/applications/$dskNM
      cp -r ${_app}/share/icons $out/share/icons
      # wrapProgram $out/bin/bookworm --prefix PATH : ${pkgs.lib.makeBinPath packages}
    '')
  ];
}
