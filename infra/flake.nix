{
  description = "K3s server on Proxmox";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-generators }: {
    nixosConfigurations.k3s-server = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./cluster.nix
        ./proxmox.nix
        ({ pkgs, ... }: {
          networking.hostName = "lab";
          
          environment.systemPackages = with pkgs; [
            vim
            wget
            git
          ];

          users.users.leo = {
            isNormalUser = true;
            description = "leo";
            extraGroups = [ "networkmanager" "wheel" ];
            # openssh.authorizedKeys.keyFiles = [
            #   ./ssh.pub
            # ];
            initialHashedPassword = "$6$Xg18ngZPapzjw5j1$IA2zCuk7IKW2jb1PBCIQyUARIjO0PJCcxvP49G3j3PGdX.qSUhvMU8MamEfXK8ZfiXMz70Ql16rnlhkFY0FWd1"; #mkpasswd -m sha-512
          };
        })
      ];
    };

    packages.x86_64-linux.proxmox = nixos-generators.nixosGenerate {
      system = "x86_64-linux";
      format = "proxmox";
      modules = [
        ./cluster.nix
        ./proxmox.nix
        ({ pkgs, ... }: {
          networking.hostName = "lab";
          
          environment.systemPackages = with pkgs; [
            vim
            wget
            git
          ];

          users.users.leo = {
            isNormalUser = true;
            description = "leo";
            extraGroups = [ "networkmanager" "wheel" ];
            # openssh.authorizedKeys.keyFiles = [
            #   ./ssh.pub
            # ];
            initialHashedPassword = "$6$Xg18ngZPapzjw5j1$IA2zCuk7IKW2jb1PBCIQyUARIjO0PJCcxvP49G3j3PGdX.qSUhvMU8MamEfXK8ZfiXMz70Ql16rnlhkFY0FWd1";
          };
        })
      ];
    };
  };
}
