# Sudoku solver in Nix

Sudoku solver in Nix using a simple backtracking algorithm.

Run the following command, replacing `./puzzle1.txt` with the path of a puzzle of your choice (with zeroes representing blank squares).

```ShellSession
$ nix-instantiate --eval -E 'import ./sudoku.nix ./puzzle1.txt' | jq -r
# or using newer Nix command
$ nix eval --raw --impure --expr 'import ./sudoku.nix ./puzzle1.txt'
1 4 3 9 8 6 2 5 7
6 7 9 4 2 5 3 8 1
2 8 5 7 3 1 6 9 4
9 6 2 3 5 4 1 7 8
3 5 7 6 1 8 9 4 2
4 1 8 2 7 9 5 6 3
8 2 1 5 6 7 4 3 9
7 9 6 1 4 3 8 2 5
5 3 4 8 9 2 7 1 6
$ nix eval --raw --impure --expr 'import ./sudoku.nix ./puzzle2.txt'
No solution!
```

## How fast is it?
Beats solving by hand.  If you know how to make it faster, please submit PRs!

```
$ nix run nixpkgs#hyperfine -- "nix-instantiate --eval -E 'import ./sudoku.nix ./puzzle1.txt'"
Benchmark 1: nix-instantiate --eval -E 'import ./sudoku.nix ./puzzle1.txt'
  Time (mean ± σ):     642.4 ms ±  50.4 ms    [User: 526.1 ms, System: 100.8 ms]
  Range (min … max):   589.6 ms … 746.8 ms    10 runs
```

## Why did you write this?
Because I could.
