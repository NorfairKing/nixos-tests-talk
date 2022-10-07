{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=96ceff97da009d9605287e70cd20b04409ea30c6";
    nixpkgs.flake = false;
  };

  outputs = { self, nixpkgs }:
    let pkgs = import nixpkgs { system = "x86_64-linux"; config.allowBroken = true; };
    in
    {
      checks.x86_64-linux = {
        example = import ./example-nixos-test.nix { inherit pkgs; };
        template = import ./template-nixos-test.nix { inherit pkgs; };
      };
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "nixos-tests-talk-shell";
        buildInputs = with pkgs; [
          haskellPackages.patat
        ];
      };
    };
}
