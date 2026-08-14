# Plot a fen representation chessboard via ggplot2

Function to show the fen string in ggplot2.

## Usage

``` r
ggchessboard(
  fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
  cellcols = c("#D2B48C", "#F5F5DC"),
  perspective = "white",
  piecesize = 15,
  labelsize = 13
)
```

## Arguments

- fen:

  Fen notation of a chessboard

- cellcols:

  A 2 length vector fot the cell colors

- perspective:

  A string to show the perspective (black, white)

- piecesize:

  Size of the the unicode texts

- labelsize:

  Size of the position indicators

## Value

A ggplot object

## Examples

``` r

board <- ggchessboard()

board <- ggchessboard(fen = "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2")

board <- ggchessboard(fen = "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2",
             cellcols = c("#CCCCCC", "#FAFAFA"),
             piecesize = 17,
             perspective = "black")
```
