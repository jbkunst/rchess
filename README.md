# rchess
<!-- README.md is generated from README.Rmd -->



[![travis-status](https://api.travis-ci.org/jbkunst/rchess.svg)](https://travis-ci.org/jbkunst/rchess)
[![version](http://www.r-pkg.org/badges/version/rchess)](http://www.r-pkg.org/pkg/rchess)
[![downloads](http://cranlogs.r-pkg.org/badges/rchess)](http://www.r-pkg.org/pkg/rchess)

## Introduction

The `rchess` package is a chess move, generation/validation, piece placement/movement, and check/checkmate/stalemate detection.
 

## Installation

You can install the latest development version from github with:


```r
devtools::install_github("jbkunst/rchess")
```

## Basic Usage


```r
chss <- Chess$new()

chss
## 
## Turn
## w
## 
## Number of moves
## 0
## 
## History
## 
## 
## Fen representation
## rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1
## 
## Board
##    +------------------------+
##  8 | r  n  b  q  k  b  n  r |
##  7 | p  p  p  p  p  p  p  p |
##  6 | .  .  .  .  .  .  .  . |
##  5 | .  .  .  .  .  .  .  . |
##  4 | .  .  .  .  .  .  .  . |
##  3 | .  .  .  .  .  .  .  . |
##  2 | P  P  P  P  P  P  P  P |
##  1 | R  N  B  Q  K  B  N  R |
##    +------------------------+
##      a  b  c  d  e  f  g  h

chss$moves()
##  [1] "a3"  "a4"  "b3"  "b4"  "c3"  "c4"  "d3"  "d4"  "e3"  "e4"  "f3" 
## [12] "f4"  "g3"  "g4"  "h3"  "h4"  "Na3" "Nc3" "Nf3" "Nh3"

head(chss$moves(verbose = TRUE))
```



|color |from |to |flags |piece |san |
|:-----|:----|:--|:-----|:-----|:---|
|w     |a2   |a3 |n     |p     |a3  |
|w     |a2   |a4 |b     |p     |a4  |
|w     |b2   |b3 |n     |p     |b3  |
|w     |b2   |b4 |b     |p     |b4  |
|w     |c2   |c3 |n     |p     |c3  |
|w     |c2   |c4 |b     |p     |c4  |

```r

chss$move("a3")
```


We can concate some moves (and a captures)


```r
chss$move("e5")$move("f4")$move("Qe7")$move("fxe5")
```



```r
plot(chss)
```

![alt text](inst/extimg/plot_chssbrdjs.png)
*This is an image for the readme. The real one is a html document powered by [cheesboarjs](http://chessboardjs.com/).*


```r

chss$turn()
## [1] "b"

chss$square_color("h1")
## [1] "light"

chss$get("e5")
## $type
## [1] "p"
## 
## $color
## [1] "w"

head(chss$history(verbose = TRUE))
```



|color |from |to |flags |piece |san  |captured |
|:-----|:----|:--|:-----|:-----|:----|:--------|
|w     |a2   |a3 |n     |p     |a3   |NA       |
|b     |e7   |e5 |b     |p     |e5   |NA       |
|w     |f2   |f4 |b     |p     |f4   |NA       |
|b     |d8   |e7 |n     |q     |Qe7  |NA       |
|w     |f4   |e5 |c     |p     |fxe5 |p        |

```r

chss$history()
## [1] "a3"   "e5"   "f4"   "Qe7"  "fxe5"

chss$undo()
## $color
## [1] "w"
## 
## $from
## [1] "f4"
## 
## $to
## [1] "e5"
## 
## $flags
## [1] "c"
## 
## $piece
## [1] "p"
## 
## $captured
## [1] "p"
## 
## $san
## [1] "fxe5"

chss$history()
## [1] "a3"  "e5"  "f4"  "Qe7"

chss$fen()
## [1] "rnb1kbnr/ppppqppp/8/4p3/5P2/P7/1PPPP1PP/RNBQKBNR w KQkq - 1 3"

chss$header("White", "You")

chss$header("Black", "Me")

cat(chss$pgn())
## [White "You"]
## [Black "Me"]
## 
## 1. a3 e5 2. f4 Qe7

chss$ascii()
##    +------------------------+
##  8 | r  n  b  .  k  b  n  r |
##  7 | p  p  p  p  q  p  p  p |
##  6 | .  .  .  .  .  .  .  . |
##  5 | .  .  .  .  p  .  .  . |
##  4 | .  .  .  .  .  P  .  . |
##  3 | P  .  .  .  .  .  .  . |
##  2 | .  P  P  P  P  .  P  P |
##  1 | R  N  B  Q  K  B  N  R |
##    +------------------------+
##      a  b  c  d  e  f  g  h
```

## Ohter funcionalities

Other functions for validation and load position and games you
can see  in [this link](https://rawgit.com/jbkunst/rchess/master/dontrun/test.html).

## Under the hood

This package is basically a wrapper of [chessjs](https://github.com/jhlywa/chess.js) by [jhlywa](https://github.com/jhlywa).

The main parts in this package are:

- V8 package and chessjs javascript library.
- R6 package for the OO system.
- htmlwidget package and chessboardjs javascript library.

Thanks to the creators and maintainers of these packages and libraries.


## Session Info


```r
print(sessionInfo())
## R version 3.1.3 (2015-03-09)
## Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows 8 x64 (build 9200)
## 
## locale:
## [1] LC_COLLATE=Spanish_Chile.1252  LC_CTYPE=Spanish_Chile.1252   
## [3] LC_MONETARY=Spanish_Chile.1252 LC_NUMERIC=C                  
## [5] LC_TIME=Spanish_Chile.1252    
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] printr_0.0.4 rchess_0.1  
## 
## loaded via a namespace (and not attached):
##  [1] assertthat_0.1   curl_0.9.3       digest_0.6.8     evaluate_0.8    
##  [5] formatR_1.2.1    highr_0.5.1      htmltools_0.2.6  htmlwidgets_0.5 
##  [9] jsonlite_0.9.17  knitr_1.11       magrittr_1.5     R6_2.1.1        
## [13] Rcpp_0.12.1      rmarkdown_0.8    rstudioapi_0.3.1 stringi_0.5-5   
## [17] stringr_1.0.0    tools_3.1.3      V8_0.8           yaml_2.1.13
```
