# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    inputs.daeuniverse.nixosModules.dae
    inputs.daeuniverse.nixosModules.daed
  ];

#   services.dae = {
#     enable = true;
#     configFile = "/tmp/dae.dae";
#   };
  services.daed = {
    enable = true;
    # listen = "0.0.0.0:2023";
  };

#   virtualisation.oci-containers.containers."subconverter" = {
#     image = "tindy2013/subconverter:latest";
#     ports = [ "25500:25500" ];
#   };
  
  /*
  # 必须开启内核转发，这是透明代理的基础
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
  */

}


# journalctl -u daed -f

/*

DB_PATH="/etc/daed/wing.db"

{
    # 1. 提取 Global (并去掉多余的引号，防止 dae 报错)
    sqlite3 "$DB_PATH" "SELECT global FROM configs LIMIT 1;" | sed 's/"//g'

    # 2. 提取并格式化 Subscriptions (使用 tag 字段)
    echo -e "\nsubscription {"
    sqlite3 "$DB_PATH" "SELECT printf('  %s: ''%s''', tag, link) FROM subscriptions;"
    echo "}"

    # 3. 提取并格式化 Groups
    echo -e "\ngroup {"
    # 获取所有订阅的 tag 组合
    SUBS_TAGS=$(sqlite3 "$DB_PATH" "SELECT group_concat(tag) FROM subscriptions;")
    sqlite3 "$DB_PATH" "SELECT printf('  %s { filter: subtag(%s) policy: %s }', name, '$SUBS_TAGS', policy) FROM groups;"
    echo "}"

    # 4. 提取 DNS
    sqlite3 "$DB_PATH" "SELECT dns FROM dns LIMIT 1;"

    # 5. 提取选中的 Routing (使用你查到的 routings 表名)
    echo -e "\nrouting {"
    sqlite3 "$DB_PATH" "SELECT routing FROM routings WHERE selected = 1 LIMIT 1;"
    echo "}"

} > /dev/stdout

*/