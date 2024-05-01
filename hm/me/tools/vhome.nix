{pkgs, ...}:
{
  home.packages = [pkgs.bubblewrap];
  programs.bash = {
    bashrcExtra = ''
      [[ -f /etc/nixos/hm/me/tools/vhome.sh ]] && . /etc/nixos/hm/me/tools/vhome.sh
    '';
  };
}
