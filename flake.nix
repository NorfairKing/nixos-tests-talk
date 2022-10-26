{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-22.05";
    # We need an old nixpkgs version to make patat work for now:
    # https://github.com/jaspervdj/patat/issues/123
    nixpkgs-old.url = "github:NixOS/nixpkgs?ref=96ceff97da009d9605287e70cd20b04409ea30c6";
    nixpkgs-old.flake = false;
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-old
    , pre-commit-hooks
    }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      patat = (import nixpkgs-old { system = "x86_64-linux"; config.allowBroken = true; }).haskellPackages.patat;
    in
    {
      checks.x86_64-linux = {
        example = import ./example-nixos-test.nix { inherit pkgs; };
        template = import ./template-nixos-test.nix { inherit pkgs; };
        pre-commit = pre-commit-hooks.lib.x86_64-linux.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
          };
        };
      };
      apps.x86_64-linux.default = {
        type = "app";
        program = "${pkgs.writeShellScript "presentation" ''
          ${patat}/bin/patat ${./presentation.md}
        ''}";
      };
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "nixos-tests-talk-shell";
        buildInputs = with pkgs; [
          patat
          nixpkgs-fmt
        ];
        shellHook = self.checks.x86_64-linux.pre-commit.shellHook;
      };
    };
}
