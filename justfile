set unstable := true

#set quiet := true

debug := "false"
[private]
trace := if env("DEBUG", debug) == "true" { "--show-trace" } else { "" }

check:
    nix flake check {{ trace }} 

[private]
system action="dry-activate":
    sudo nixos-rebuild {{ action }}  --flake .#master {{ trace }}

build action="build":
    nixos-rebuild {{ action }}  --flake .#master {{ trace }}

test: (system "test")

boot: (system "boot")

switch: (system "switch")

list:
    nixos-rebuild list-generations

update:
    nix flake update

clean:
    nix store gc

optimise:
    nix store optimise
