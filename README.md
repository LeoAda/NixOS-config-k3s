# NixOS-config-k3s
## On wsl nixos
sudo nixos-rebuild switch
nix flake init 
## To build proxmox image
nix build .#packages.x86_64-linux.proxmox
## Update image

cd ~/NixOS-config-k3s/infra
sudo git pull
cd infra
sudo nixos-rebuild switch --flake .#k3s-server