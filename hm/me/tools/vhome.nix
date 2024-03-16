{pkgs, ...}:
{
  home.packages = [pkgs.bubblewrap];
  programs.bash = {
    bashrcExtra = ''
      source /etc/nixos/hm/me/tools/vhome.sh 
    '';
  };
}
