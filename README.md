# printNixPkgsPath
Nix function that generates simple shell function to print out all output paths of listed packages on nix store.

## Usage

This is expected to be used in devShell's shellHook.

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    printNixPkgsPath.url = "github:kenryus/printNixPkgsPath";
  };

  outputs = { self, nixpkgs, printNixPkgsPath }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    lib = pkgs.lib;
    printNixPkgsPath_cmd = import printNixPkgsPath;
    nativeBuildInputs = with pkgs; [
      cmake
      cowsay
      pkgconf
    ];
  in
    {
      devShell.system.default = pkgs.stdenv.mkDerivation {
        name = "dev shell";
        inherit nativeBuildInputs;
        shellHook = ''
          ${printNixPkgsPath_cmd nativeBuildInputs}
        '';
      };
    };
}
```

Enter to devShell with `nix develop` then check where in the Nix store the packages live with this command:

```bash
$ printNixPkgsPath
```

Example Output:

```
cmake-3.31.7:
    /nix/store/0vnarm4qjnj16dr3zj9kwq6bn79c0icn-cmake-3.31.7
    /nix/store/nnpfia0s39cy3l7rq2pnn2axs8k625jw-cmake-3.31.7-debug
cowsay-3.8.4:
    /nix/store/d57d247hx61ljfxf67ggsgynd16gh2p8-cowsay-3.8.4
    /nix/store/y63wh8j3xkxrhsm8fr1w2s8k2nj0qrlr-cowsay-3.8.4-man
pkgconf-wrapper-2.4.3:
    /nix/store/b6wz03kpkjvn6accwhnw6k6qki628dnx-pkgconf-wrapper-2.4.3
    /nix/store/fv6kwj4w16wr0sryz49g753xq9abdvy1-pkgconf-wrapper-2.4.3-man
    /nix/store/fbqbl740i7w68gfglkpr3hjz18yf37j5-pkgconf-wrapper-2.4.3-doc
```
