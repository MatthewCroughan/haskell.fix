{ pkgs, inputs }:
((pkgs.haskell-nix.project' {
  src = ./.;
  projectFileName = "stack.yaml";
}).flake {}).packages."hello-world:exe:hello-world"
