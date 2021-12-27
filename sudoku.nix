{ lib ? (import <nixpkgs> {}).lib }:
with lib;

let
  BOARD-SIZE = 9; ROWS = 9; COLS = 9; GRID-SIZE = 3;
  get-row = r: board: elemAt board r;
  get-column = c: board: map (row: elemAt row c) board;
  get-block = br: bc: puzzle:
    concatMap (r: (take GRID-SIZE (drop (GRID-SIZE * bc) r)))
              (take GRID-SIZE (drop (GRID-SIZE * br) puzzle));
  readPuzzle = f: map (x: map toInt (splitString " " x))
                      (init (splitString "\n" (readFile f)));
  get-value = board: row: col: elemAt (elemAt board row) col;
  safe-to-put = r: c: n: board:
    let v = get-value board r c; in
    if n == v then true else
    if v == 0 then !(elem n (get-row r board) ||
                     elem n (get-column c board) ||
                     elem n (get-block (r / GRID-SIZE)
                                       (c / GRID-SIZE)
                                       board))
    else false;
  print-row = r: concatStringsSep " " (map toString r) + "\n";
  print-board = b: concatStrings (map print-row b);
  list-set = l: n: x: take n l ++ [x] ++ (tail (drop n l));
  set-value = board: row: col: num:
      list-set board row (list-set (elemAt board row) col num);
  and' = x: y: if x == false then false else y;
  or' = x: y: if x == false then y else x;
  try-placing = r: c: n: board:
    and' (safe-to-put r c n board) (set-value board r c n);
  go = n: r: c: board:
    if r == BOARD-SIZE then board else
    if n == 10 then false else
     let nb = try-placing r c n board;
         nr = r + (if c == COLS - 1 then 1 else 0);
         nc = mod (c + 1) COLS;
      in or' (and' nb (go 1 nr nc nb))
             (go (n + 1) r c board);
  solve = go 1 0 0;
in
{
  inherit solve readPuzzle;
  solveFile = f: solve (readPuzzle f);
  demo = f: let res = solve (readPuzzle f); in
    if res == false then "No solution!" else print-board res;
}
