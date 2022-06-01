{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
  outputs = { self, nixpkgs }: {
    lib.fixHaskellDotNix = import ./haskell.fix nixpkgs.lib;
  };
}
