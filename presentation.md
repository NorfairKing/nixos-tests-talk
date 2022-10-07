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

# Little example

<!--

vim example-nixos-test.nix

-->

# Write your own NixOS test!

<!--

cp template-nixos-test.nix my-nixos-test.nix
nix-build my-nixos-test.nix

-->

# References
