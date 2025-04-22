{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";

    flake-utils.url = "github:numtide/flake-utils/v1.0.0";
  };

  # Custom colored bash prompt
  nixConfig.bash-prompt = ''\[\e[0;32m\][LLZK]\[\e[m\] \[\e[38;5;244m\]\w\[\e[m\] % '';

  outputs = { self, nixpkgs, flake-utils }:
    {
      # First, we define the packages used in this repository/flake
      overlays.default = final: prev: {
        changelogCreator = final.stdenv.mkDerivation rec {
          name = "create-changelog";
          src = ./scripts;
          buildInputs = [ final.bash final.git ];

          installPhase = ''
            mkdir -p $out/bin
            cp ${src}/createChangelogEntry.sh $out/bin/${name}
            cp ${src}/template.yaml $out/bin/
            chmod +x $out/bin/${name}
          '';
        };
      };
    } //
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [
            self.overlays.default
          ];
        };
      in
      {
        packages = flake-utils.lib.flattenTree {
          default = pkgs.changelogCreator;
        };

        devShells = flake-utils.lib.flattenTree {
          default = pkgs.mkShell {
            shellHook = ''
              echo "${pkgs.changelogCreator.name} is located at ${pkgs.changelogCreator.out}."
            '';
          };
        };
      }
    ));
}
