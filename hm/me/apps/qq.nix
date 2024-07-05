# tencent qq
# var location : .var/app/qq/data
{ pkgs, ...}:
{
  home.packages = [
    (let
      _app = pkgs.qq;
      packages = with pkgs; [
          qq
      ];
    in pkgs.runCommand "qq" {
      # Dependencies that should exist in the runtime environment
      buildInputs = packages;
      # Dependencies that should only exist in the build environment
      nativeBuildInputs = [ pkgs.makeWrapper ];
    } ''
      binNM=qq
      dskNM=qq.desktop
      VHOME=qq
      
      mkdir -p $out/bin/
      echo ". /etc/nixos/hm/me/tools/vhome.sh; \
          vhome $VHOME ${_app}/bin/$binNM _" > $out/bin/$binNM
      chmod +x $out/bin/$binNM
      
      mkdir -p  $out/share/applications/
      cp -r ${_app}/share/applications/$dskNM \
         $out/share/applications/$dskNM
      sed -i "s|${_app}|$out|g" $out/share/applications/$dskNM
      # echo 'SingleMainWindow=true' >> $out/share/applications/$dskNM
      cp -r ${_app}/share/icons $out/share/icons
      # wrapProgram $out/bin/bookworm --prefix PATH : ${pkgs.lib.makeBinPath packages}
    '')
  ];
}
