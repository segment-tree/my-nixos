# bookworm a epub & pdf reader
# var location : .var/app/epub/data
{pkgs, ...}:
{
  home.packages = [
    (let
      _app = pkgs.bookworm;
      packages = with pkgs; [
          bookworm
      ];
    in pkgs.runCommand "bookworm" {
      # Dependencies that should exist in the runtime environment
      buildInputs = packages;
      # Dependencies that should only exist in the build environment
      nativeBuildInputs = [ pkgs.makeWrapper ];
    } ''
      appNM=bookworm
      binNM=com.github.babluboy.bookworm
      dskNM=com.github.babluboy.bookworm.desktop
      
      mkdir -p $out/bin/
      echo ". /etc/nixos/hm/me/tools/vhome.sh; \
          vhome epub ${_app}/bin/$binNM _" > $out/bin/$appNM
      chmod +x $out/bin/$appNM
      
      echo $out/bin/$appNM > $out/bin/$binNM
      chmod +x $out/bin/$binNM
      mkdir -p  $out/share/applications/
      cp -r ${_app}/share/applications/$dskNM \
         $out/share/applications/$dskNM
      sed -i "s|${_app}|$out|g" $out/share/applications/$dskNM
      cp -r ${_app}/share/icons $out/share/icons
      # wrapProgram $out/bin/bookworm --prefix PATH : ${pkgs.lib.makeBinPath packages}
    '')
  ];
}