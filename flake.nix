{
  description = "Development dependencies";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs_unstable.url = "github:NixOS/nixpkgs/95ce89e45b15ce1d0d4f69e6d6d74fe8e8667bc0";
    nixpkgs_talos.url = "github:NixOS/nixpkgs/bfe27cf81c881138fcaa0329b3ad51832558dcab";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs_unstable, nixpkgs_talos, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        pkg-unstable = import nixpkgs_unstable {
          inherit system;
        };
        pkg-talos = import nixpkgs_talos {
          inherit system;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            age
            ansible
            bash
            curl
            git
            jq
            kubectl
            kubernetes-helm
            passage
            vcluster
            yq
            pkg-unstable.k9s
            pkg-talos.talosctl
            pkg-unstable.go
            pkg-unstable.go-tools
            cilium-cli
            git-secret
            crane
            pkg-unstable.cosign
            gnupg
            mage
            skopeo
            golangci-lint
            kubectl
            kubectl-ktop
            kubectl-tree
            kubectx
            kubevirt
            stern
            krew
            pkg-unstable.opentofu
            oras
            cfssl
            openjdk
            pkg-unstable.zarf
            sqlcmd
            glibcLocales
            powershell
          ];
        };
      });
}
