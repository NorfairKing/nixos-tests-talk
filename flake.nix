{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-22.05";
    # We need an old nixpkgs version to make patat work for now:
    # https://github.com/jaspervdj/patat/issues/123
    nixpkgs-old.url = "github:NixOS/nixpkgs?ref=96ceff97da009d9605287e70cd20b04409ea30c6";
    nixpkgs-old.flake = false;
  };

  outputs = { self, nixpkgs, nixpkgs-old }:
    let pkgs = import nixpkgs { system = "x86_64-linux"; };
        patat = (import nixpkgs-old { system = "x86_64-linux"; config.allowBroken = true; }).haskellPackages.patat;
    in
    {
      packages.x86_64-linux = {
        example = import ./example-nixos-test.nix { inherit pkgs; };
        template = import ./template-nixos-test.nix { inherit pkgs; };
      };
      apps.x86_64-linux.default = {
        type = "app";
        program = "${patat}/bin/patat";
      };
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "nixos-tests-talk-shell";
        buildInputs = with pkgs; [
          patat
        ];
      };
    };
}
