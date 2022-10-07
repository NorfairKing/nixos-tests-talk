{ pkgs ? import <nixpkgs> {}
}:
pkgs.nixosTest {
  name = "example-nixos-test";
  nodes.machine = {
    services.gitea = {
      enable = true;
    };
  };
  testScript = ''
    machine.start()
    machine.wait_for_unit("multi-user.target")
    machine.wait_for_open_port(3000) # Gitea listens on port 3000
    machine.succeed("curl localhost:3000")
  '';
}
