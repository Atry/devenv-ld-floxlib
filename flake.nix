{
  inputs = {
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    ld-floxlib.url = "github:flox/ld-floxlib";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, systems, ld-floxlib, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {

                  env = {
                    LD_AUDIT = "${ld-floxlib.packages.${system}.ld-floxlib}/lib/ld-floxlib.so";

                    FLOX_ENV = pkgs.symlinkJoin {
                      name = "flox-env";
                      paths = [
                        pkgs.zlib

                        # Other fallback libraries
                      ];
                    };
                  };

                  enterShell = ''
                    export LD_FLOXLIB_AUDIT_IMPURE=1
                    export LD_FLOXLIB_DEBUG=1
                    python -m grpc_tools.protoc --help
                  '';

                  languages.python = {
                    enable = true;
                    venv = {
                      enable = true;
                      requirements = ''
                        grpcio-tools
                      '';
                    };
                  };
                }
              ];
            };
          });
    };
}