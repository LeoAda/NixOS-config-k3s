{ config,pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ nfs-utils openiscsi k3s  ];
  ## Network
  networking.firewall.allowedTCPPorts = [
    6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
    # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
    # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
  ];
  networking.firewall.allowedUDPPorts = [
    8472  # k3s, flannel: required if using multi-node for inter-node networking
  ];
  ## K3S
  services.k3s = {
    enable = true;
    role = "server";
    token = "12345";
    clusterInit = true;
    extraFlags = toString [
    "--disable=traefik" "--disable=servicelb" "--disable local-storage"
    ];
  };
  ## Storage
  services.openiscsi = {
    enable = true;
    name = "${config.networking.hostName}-initiatorhost";
  };
  boot.supportedFilesystems = [ "nfs" ];
  services.rpcbind.enable = true;
  boot.kernelModules = [ "rbd" ];
  systemd.services.iscsid.serviceConfig = {
    PrivateMounts = "yes";
    BindPaths = "/run/current-system/sw/bin:/bin";
  };
  system.activationScripts.binMount = ''
    mkdir -p /bin
    ln -sf /run/current-system/sw/bin/mount /bin/mount
    ln -sf /run/current-system/sw/bin/umount /bin/umount
  '';
  system.stateVersion = "25.11";
}