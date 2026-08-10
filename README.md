# ♛ `rchess` — Chess tools for R

[![R-CMD-check](https://github.com/jbkunst/rchess/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jbkunst/rchess/actions/workflows/R-CMD-check.yaml)

`rchess` provides chess move generation and validation, piece placement and
movement, game-state detection, and board visualization from R. It wraps the
bundled [chess.js](https://github.com/jhlywa/chess.js) JavaScript library and
includes both an HTML widget and a `ggplot2` board renderer.

> **CRAN status:** `rchess` was archived on November 14, 2023. Until a new CRAN
> release is prepared, install the maintained development version from GitHub.

## Installation

```r
# install.packages("pak")
pak::pak("jbkunst/rchess")
```

## Quick start

```r
library(rchess)

game <- Chess$new()

game$moves()
game$move("e4")
game$move("e5")
game$fen()
game$history()
```

Plot the current position with the HTML widget:

```r
plot(game)
```

Or use the `ggplot2` renderer:

```r
plot(game, type = "ggplot")
```

## Documentation

Package documentation and examples are being rebuilt with pkgdown at
<https://jbkunst.github.io/rchess/>.

## Development

Issues and pull requests are welcome at
<https://github.com/jbkunst/rchess>.
