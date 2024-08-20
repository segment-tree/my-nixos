{ inputs, lib, config, pkgs-stable, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  
  home-manager.backupFileExtension= "~/.var/hm";
  
  # home-manager.users.me = import ./me/home.nix;
  home-manager.users.me.imports = [ ./me/home.nix ];
  home-manager.users.me._module.args = {
    inherit (inputs.nur);
    inherit inputs;
    inherit pkgs-stable;
  };
  
  home-manager.users.gdm = lib.mkIf config.mine.machine.isVM ({ lib, ... }: {
    dconf.settings."org/gnome/desktop/interface".scaling-factor = lib.hm.gvariant.mkUint32 2;
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;
  });
  
  # 使用 home-manager.extraSpecialArgs 自定义传递给 ./home.nix 的参数
  # 取消注释下面这一行，就可以在 home.nix 中使用 flake 的所有 inputs 参数了
  home-manager.extraSpecialArgs = inputs;
}
# See https://discourse.nixos.org/t/how-to-move-home-manager-definition-into-a-separate-file/28034/2
