{ pkgs ? import <nixpkgs> {}
}:
pkgs.nixosTest {
  name = "example-nixos-test";
  nodes.machine = {
  };
  testScript = ''
    machine.start()
    machine.wait_for_unit("multi-user.target")
  '';
}
