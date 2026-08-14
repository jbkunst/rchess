# FIDE World Cups data

This data comes from the <https://theweekinchess.com/> site and
represent 1,266 games in the FIDE World Cupo 11, 13 and 15. The data has
been parsed from the downloaded pgn files using
<https://github.com/jbkunst/chess-db> scripts.

## Usage

``` r
data(chesswc)
```

## Format

A `data frame` with 1,266 observations and 11 variables.

## Links

- https://theweekinchess.com/chessnews/events/fide-world-cup-2015

- https://theweekinchess.com/chessnews/events/fide-world-cup-tromso-2013

- https://theweekinchess.com/chessnews/events/fide-world-cup-khanty-mansiysk-2011

## Variables

- `event`: Games's event

- `site`: Games's location

- `date`: Game's date

- `round`: Games's round

- `white`: White player's name

- `black`: Black player's name

- `result`: Game's result

- `whiteelo`: White player's elo rating

- `blackelo`: Black player's elo rating

- `eco`: The game's opening classification

- `pgn`: The game's pgn

## Examples

``` r
data(chesswc)
dplyr::count(chesswc, event)
#> # A tibble: 3 × 2
#>   event                   n
#>   <chr>               <int>
#> 1 FIDE World Cup 2011   398
#> 2 FIDE World Cup 2013   435
#> 3 FIDE World Cup 2015   433
```
