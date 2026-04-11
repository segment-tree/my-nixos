{ config, pkgs, osConfig, ... }:

{
  home.packages = with pkgs;[
    github-copilot-cli
  ];
}