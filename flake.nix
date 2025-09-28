{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      ...
    }:
    let
      system = "x86_64-linux";
      unstable = import nixpkgs-unstable { inherit system; };
      colorscheme = import ./settings/colorscheme.nix;
    in
    {
      nixosConfigurations.master = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit colorscheme unstable;
        };
        modules = [
          ./system
          ({
            nix = {
              enable = true;
              settings = {
                experimental-features = [
                  "nix-command"
                  "flakes"
                ];
              };
              registry = {
                unstable.to = {
                  type = "path";
                  path = self.inputs.nixpkgs-unstable.outPath;
                };
                templates.to = {
                  owner = "NixOS";
                  repo = "templates";
                  type = "github";
                };
              };
              extraOptions = ''
                flake-registry = 
              '';
            };
          })
        ];
      };
    };
}
