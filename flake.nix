{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };
  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      ...
    }:
    let
      system = "x86_64-linux";
      unstable = import nixpkgs-unstable { inherit system; };
      colorscheme = import ./configuration/colorscheme.nix;
    in
    {
      nixosConfigurations.master = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit colorscheme unstable;
        };
        modules = [
          ./configuration
        ];
      };
    };
}
