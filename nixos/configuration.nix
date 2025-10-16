{ config, lib,pkgs, ... }:
{
  imports = [
   ./hardware-configuration.nix
   ./cluster.nix  
];
  boot.loader.systemd-boot.enable= true;
  boot.loader.efi.canTouchEfiVariables = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    disko
  ];
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
    };
};
  users.users.leo = {
    isNormalUser = true;
    description = "leo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };
  networking.hostName = "lab";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
  networking.firewall.enable = false;
  time.timeZone = "Europe/Paris";
  console.keyMap = "fr";
}