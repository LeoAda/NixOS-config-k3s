{ config, pkgs, ... }:

{
  imports = [
  ];
  environment.systemPackages = with pkgs; [
    vscode
    nixfmt-rfc-style
    nixd
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        jnoortheen.nix-ide
        christian-kohler.path-intellisense
      ];
    })
  ];

}
