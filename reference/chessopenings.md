# Chess openings data

This data comes from the chess Chess Opening Theory wikibook
<https://en.wikibooks.org/wiki/Chess_Opening_Theory>. The oppening were
parse using `rvest` package.

## Usage

``` r
data(chessopenings)
```

## Format

A `data frame` with 544 observations and 3 variables.

## Links

- https://en.wikibooks.org/wiki/Chess_Opening_Theory/ECO_volume_A

- https://en.wikibooks.org/wiki/Chess_Opening_Theory/ECO_volume_B

- https://en.wikibooks.org/wiki/Chess_Opening_Theory/ECO_volume_C

- https://en.wikibooks.org/wiki/Chess_Opening_Theory/ECO_volume_D

- https://en.wikibooks.org/wiki/Chess_Opening_Theory/ECO_volume_E

## Variables

- `eco`: The game's opening classification

- `name`: Games's location

- `pgn`: The game's pgn

## Examples

``` r
data(chessopenings)
head(chessopenings)
#> # A tibble: 6 × 4
#>   eco   name              variant                   pgn       
#>   <chr> <chr>             <chr>                     <chr>     
#> 1 A01   Irregular Opening Nimzowitsch-Larsen Attack 1. b3     
#> 2 A02   Bird's Opening    Bird's Opening            1. f4     
#> 3 A03   Bird's Opening    Bird's Opening            1. f4 d5  
#> 4 A04   Irregular Opening Reti Opening              1. Nf3    
#> 5 A05   Irregular Opening Reti Opening              1. Nf3 Nf6
#> 6 A06   Irregular Opening Reti Opening              1. Nf3 d5 
```
