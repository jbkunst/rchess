# ♛ `rchess` — Chess tools for R

[![R-CMD-check](https://github.com/jbkunst/rchess/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jbkunst/rchess/actions/workflows/R-CMD-check.yaml)
[![pkgdown](https://github.com/jbkunst/rchess/actions/workflows/pkgdown.yaml/badge.svg)](https://jkunst.com/rchess/)

`rchess` provides chess move generation and validation, piece placement and
movement, game-state inspection, and board visualization from R. It wraps the
bundled [chess.js](https://github.com/jhlywa/chess.js) library and includes both
an HTML widget and a `ggplot2` board renderer.

> **Package status:** `rchess` was archived on CRAN on November 14, 2023.
> Install the maintained development version from GitHub while a new CRAN
> release is prepared.

## Installation

Install the development version with [`pak`](https://pak.r-lib.org/):

```r
pak::pak("jbkunst/rchess")
```

## Quick start

```r
library(rchess)

game <- Chess$new()

game$moves()
game$move("e4")$move("e5")
game$fen()
game$history()
```

Render the current position as an interactive HTML widget:

```r
plot(game)
```

Or return a `ggplot2` board:

```r
plot(game, type = "ggplot")
```

Detailed move history is returned as a modern tibble:

```r
game$history(verbose = TRUE)
game$history_detail()
```

## Documentation

The full function reference and examples are available on the
[pkgdown website](https://jkunst.com/rchess/). The site uses this
Markdown document as its home page, so GitHub and the package documentation
stay aligned.

## Development

Issues and pull requests are welcome in the
[GitHub repository](https://github.com/jbkunst/rchess).
