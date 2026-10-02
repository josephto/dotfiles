{
  description = "dotfiles";

  inputs = {
    # Use Nixpkgs 26.05.
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";

    # Use nix-darwin 26.05.
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  
     # Manage Homebrew declaratively.
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Use Home Manager 26.05 to match Nixpkgs.
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
    let
      # Shared modules + hosts/<host>/{darwin,home}.nix for that machine.
      mkHost = { host, username }: nix-darwin.lib.darwinSystem {
        specialArgs = { inherit username; };
        modules = [
          ./modules/darwin.nix
          ./hosts/${host}/darwin.nix
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # Move pre-existing files (e.g. ~/.zshrc) aside instead of failing.
            home-manager.backupFileExtension = "before-home-manager";
            home-manager.extraSpecialArgs = { inherit username; };
            home-manager.users.${username}.imports = [
              ./modules/home.nix
              ./hosts/${host}/home.nix
            ];
          }
        ];
      };
    in {
      darwinConfigurations."macbook" = mkHost { host = "personal"; username = "josephtong"; };
      darwinConfigurations."work" = mkHost { host = "work"; username = "josephtong"; };
    };
}
