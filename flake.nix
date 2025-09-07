{
  description = "Nix function that generates simple shell function to print out all output path of listed packages on nix store.";

  inputs = {};

  outputs = { ... }:
  {
    printNixPkgsPath = import ./default.nix;
  };
}
