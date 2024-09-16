{
  description = "Nix Flake for NetCoMi R package";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    SpiecEasi.url = "github:artur-sannikov/SpiecEasi/nix-flakes";
    SPRING.url = "github:artur-sannikov/SPRING/nix-flakes";
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      SpiecEasi,
      SPRING,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        SpiecEasiPkg = SpiecEasi.packages.${system}.default;
        SPRINGPkg = SPRING.rPackages.${system}.default;
        NetCoMi = pkgs.rPackages.buildRPackage {
          name = "NetCoMi";
          src = self;
          nativeBuildInputs =
            with pkgs.rPackages;
            [
              Biobase
              corrplot
              doSNOW
              fdrtool
              filematrix
              foreach
              gtools
              huge
              igraph
              MASS
              Matrix
              mixedCCA
              orca
              phyloseq
              pulsar
              qgraph
              RColorBrewer
              Rdpack
              rlang
              vegan
              WGCNA
            ]
            ++ [
              SpiecEasiPkg
              SPRINGPkg
            ];
        };
      in
      {
        packages.default = NetCoMi;
        devShells.default = pkgs.mkShell {
          buildInputs = [ NetCoMi ];
          inputsFrom = pkgs.lib.singleton NetCoMi;
        };
      }
    );
}
