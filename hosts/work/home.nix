{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
  ];
  home.sessionVariables = {
    N_PREFIX = "${config.home.homeDirectory}/.n";
  };
  home.sessionPath = [
    "${config.home.homeDirectory}/.n/bin"
    "${config.home.homeDirectory}/.yarn/bin"
  ];
}
