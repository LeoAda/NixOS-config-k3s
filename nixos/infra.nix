{ config, pkgs, ... }:

{
  imports =
    [
      ./vmware.nix
      ./locale.nix
    ];
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];
}
