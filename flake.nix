{
  description = "Sudoku solver in Nix";
  inputs.stdlib.url = "github:manveru/nix-lib";

  outputs = { self, stdlib }:
    let f = (import ./sudoku.nix { lib = stdlib.lib; }); in
    { lib = { inherit (f) solve readPuzzle solveFile demo; }; };
}
