---
title: NixOS Tests
---

# Who am I?

See `cs-syd.eu`

# Super COOL Demo

Four virtual machines on a virtual network:
* Client
* API Server
* Web Server
* Documentation server

Backward compatibility: Client is newer.
Forward compatibility: Server is newer.

<!--

cd ~/src/smos
$ nix-build ci.nix -A e2e-test-backward-compatibility --check
$ nix-build ci.nix -A e2e-test-forward-compatibility --check

-->

# What are NixOS tests

# Little example test

<!--

vim example-nixos-test.nix

-->

# Demo Workflow

<!--

cp template-nixos-test.nix my-nixos-test.nix
git add my-nixos-test.nix
feedback -- nix-build my-nixos-test.nix

-->

# Driver

TODO: Double-check

<!--

nix-build my-nixos-test.nix -A driver

-->

# Interactive

TODO: Double-check

<!--

nix-build my-nixos-test.nix -A driverInteractive

-->

# Cool things you can do now

* Test your NixOS modules

. . .

* Write the ultimate integration tests for your app

. . .

* Write mock-free end-to-end tests for micro-services

. . .

* Write backward- and forward compatibility tests

. . .

* Replace your staging environment (maybe)

# Write your own NixOS test!

Pick a service that you use that doesn't have a test yet and make a "does it boot?" test.
See the `passthru.tests` in the package.

<!--

cp template-nixos-test.nix my-nixos-test.nix
nix-build my-nixos-test.nix

-->

# References

nixos.org/manual/nixos/stable/index.html#sec-nixos-tests
