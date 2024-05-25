{
  perSystem = { config, pkgs, ... }: {
    devShells = {
      mkdocs = pkgs.mkShellNoCC {
        inputsFrom = [
          config.packages.pages
        ];
      };
    };
    packages = {
      pages = pkgs.runCommand "pages"
        {
          buildInputs = [
            pkgs.python3.pkgs.mkdocs-material
          ];
          files = pkgs.lib.fileset.toSource {
            root = ../.;
            fileset = pkgs.lib.fileset.unions [
              ./.
              ../mkdocs.yml
            ];
          };
        }
        ''
          cd $files
          mkdocs build --strict --site-dir $out
        '';
    };
  };
}
