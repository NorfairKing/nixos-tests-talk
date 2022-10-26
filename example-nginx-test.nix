{ pkgs ? import <nixpkgs> { }
}:
pkgs.nixosTest {
  name = "example-nginx-test";
  nodes = {
    server = {
      services.nginx = {
        enable = true;
        virtualHosts = {
          "example.com" = {
            root = ./webroot;
            listen = [
              {
                addr = "0.0.0.0";
                port = 8080;
              }
            ];
          };
        };
      };
      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 8080 ];
      };
    };
    client = {
      environment.systemPackages = with pkgs; [
        curl
      ];
    };
  };
  testScript = ''
    server.start()
    client.start()
    server.wait_for_unit("multi-user.target")
    client.wait_for_unit("multi-user.target")
    client.succeed("curl server:8080 > index.html")
    client.succeed("diff index.html ${./webroot/index.html}")
  '';
}
