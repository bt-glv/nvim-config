{
  description = "bt-glv neovim config";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.writeShellApplication {
            name = "bnvim";
            runtimeInputs = with pkgs; [
							neovim
							git
							ripgrep
							fd
							gcc 
							nodejs
							tree-sitter
							wget
							unzip
							curl
							gnumake
            ];

            # 3. Wire up the isolated environment and launch Neovim
            text = ''
              # Isolate plugin data, shada, and cache from the user's default Neovim
              export NVIM_APPNAME="bnvim"

              # Prepend this Flake's directory in the Nix store to the Runtime Path (rtp)
              # so 'require("...")' finds your lua/ folder, then execute init.lua
              exec nvim --cmd "set rtp^=${./.}" -u "${./.}/init.lua" "$@"
            '';
          };
        });

      # This enables the `nix run` command to work seamlessly
      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/bnvim";
        };
      });
    };
}
