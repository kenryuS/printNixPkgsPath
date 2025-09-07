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
    printNixPkgsPath = printNixPkgsPath lib;
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
          ${printNixPkgsPath nativeBuildInputs}
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
```
