{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
  inputs.haskell-nix.url = "github:input-output-hk/haskell.nix";
  outputs = { self, nixpkgs, haskell-nix }:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    rec {
      lib.fixHaskellDotNix = import ./haskell.fix nixpkgs.lib;
      fix = args:
        self.lib.fixHaskellDotNix
          ((fixed.x86_64-linux.haskell-nix.cabalProject' args).flake {})
          (builtins.filter (x: (nixpkgs.lib.hasSuffix ".cabal" x)) (nixpkgs.lib.filesystem.listFilesRecursive args.src));
#          (cabalFiles or builtins.filter (x: (builtins.match "(.+.cabal)" (toString x)) != null ) (lib.filesystem.listFilesRecursive args.src));
      fixed = forAllSystems (system: import haskell-nix.inputs.nixpkgs {
        inherit system;
        overlays = [ haskell-nix.overlay ];
      });
    };
}
