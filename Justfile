# just is a command runner, Justfile is very similar to Makefile, but simpler.

############################################################################
#
#  Nix commands related to the local machine
#
############################################################################

a:
  #aaa

deploy:
  nixos-rebuild switch --flake . --sudo

Deploy:
  nixos-rebuild switch --flake . --sudo --impure

debug:
  nixos-rebuild switch --flake . --sudo --show-trace --verbose

Debug:
  nixos-rebuild switch --flake . --sudo --show-trace --verbose --impure


up:
  nix flake update

# Update specific input
# usage: make upp i=home-manager
upp:
  nix flake lock --update-input $(i)

history:
  nix profile history --profile /nix/var/nix/profiles/system

repl:
  nix repl -f flake:nixpkgs

clean:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
  # garbage collect all unused nix store entries
  sudo nix store gc --debug
  nix store gc --debug
  sudo nix-collect-garbage --delete-old
  nix-collect-garbage --delete-old

gitSubmit:
  git add .
  git commit


