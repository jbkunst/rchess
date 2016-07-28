# rchess
<!-- README.md is generated from README.Rmd -->




<a href="https://github.com/jbkunst/rchess" class="github-corner"><svg width="80" height="80" viewBox="0 0 250 250" style="fill:#151513; color:#fff; position: absolute; top: 0; border: 0; right: 0;"><path d="M0,0 L115,115 L130,115 L142,142 L250,250 L250,0 Z"></path><path d="M128.3,109.0 C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 C122.9,97.6 130.6,101.9 134.4,103.2" fill="currentColor" style="transform-origin: 130px 106px;" class="octo-arm"></path><path d="M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 C136.9,99.2 139.9,98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 C148.5,53.4 154.0,51.2 159.7,51.0 C160.3,49.4 163.2,43.6 171.4,40.1 C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,61.8 190.9,65.4 C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 C212.7,93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 C181.9,128.9 168.3,122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z" fill="currentColor" class="octo-body"></path></svg></a><style>.github-corner:hover .octo-arm{animation:octocat-wave 560ms ease-in-out}@keyframes octocat-wave{0%,100%{transform:rotate(0)}20%,60%{transform:rotate(-25deg)}40%,80%{transform:rotate(10deg)}}@media (max-width:500px){.github-corner:hover .octo-arm{animation:none}.github-corner .octo-arm{animation:octocat-wave 560ms ease-in-out}}</style>


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
##  [1] "a3"  "a4"  "b3"  "b4"  "c3"  "c4"  "d3"  "d4"  "e3"  "e4"  "f3"  "f4" 
## [13] "g3"  "g4"  "h3"  "h4"  "Na3" "Nc3" "Nf3" "Nh3"

chss$moves(verbose = TRUE)
## Source: local data frame [20 x 6]
## 
##    color  from    to flags piece   san
##    (chr) (chr) (chr) (chr) (chr) (chr)
## 1      w    a2    a3     n     p    a3
## 2      w    a2    a4     b     p    a4
## 3      w    b2    b3     n     p    b3
## 4      w    b2    b4     b     p    b4
## 5      w    c2    c3     n     p    c3
## 6      w    c2    c4     b     p    c4
## 7      w    d2    d3     n     p    d3
## 8      w    d2    d4     b     p    d4
## 9      w    e2    e3     n     p    e3
## 10     w    e2    e4     b     p    e4
## 11     w    f2    f3     n     p    f3
## 12     w    f2    f4     b     p    f4
## 13     w    g2    g3     n     p    g3
## 14     w    g2    g4     b     p    g4
## 15     w    h2    h3     n     p    h3
## 16     w    h2    h4     b     p    h4
## 17     w    b1    a3     n     n   Na3
## 18     w    b1    c3     n     n   Nc3
## 19     w    g1    f3     n     n   Nf3
## 20     w    g1    h3     n     n   Nh3

chss$move("a3")
```


We can concate some moves (and a captures)


```r
chss$move("e5")$move("f4")$move("Qe7")$move("fxe5")
```



```r
plot(chss)
```

<!--html_preserve--><div id="htmlwidget-3437" style="width:300px;height:300px;" class="chessboardjs"></div>
<script type="application/json" data-for="htmlwidget-3437">{"x":{"fen":"rnb1kbnr/ppppqppp/8/4P3/8/P7/1PPPP1PP/RNBQKBNR b KQkq - 0 3"},"evals":[]}</script><!--/html_preserve-->

Or a ggplot2 version (I know, I need to change the [chess pieces symbols in unicode](https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode); maybe use a chess typeface)


```r
plot(chss, type = "ggplot")
```

<p><img src="index_files/figure-html/unnamed-chunk-5-1.png"> <aside></aside></p>



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

chss$history(verbose = TRUE)
## Source: local data frame [5 x 8]
## 
##   color  from    to flags piece   san captured number_move
##   (chr) (chr) (chr) (chr) (chr) (chr)    (chr)       (int)
## 1     w    a2    a3     n     p    a3       NA           1
## 2     b    e7    e5     b     p    e5       NA           2
## 3     w    f2    f4     b     p    f4       NA           3
## 4     b    d8    e7     n     q   Qe7       NA           4
## 5     w    f4    e5     c     p  fxe5        p           5

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

## Load PGN and FEN

### FEN


```r
chssfen <- Chess$new()

fen <- "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2"

chssfen$load(fen)
## [1] TRUE

chssfen$ascii()
##    +------------------------+
##  8 | r  n  b  q  k  b  n  r |
##  7 | p  p  .  p  p  p  p  p |
##  6 | .  .  .  .  .  .  .  . |
##  5 | .  .  p  .  .  .  .  . |
##  4 | .  .  .  .  P  .  .  . |
##  3 | .  .  .  .  .  .  .  . |
##  2 | P  P  P  P  .  P  P  P |
##  1 | R  N  B  Q  K  B  N  R |
##    +------------------------+
##      a  b  c  d  e  f  g  h
```

### PGN


```r
pgn <- system.file("extdata/pgn/kasparov_vs_topalov.pgn", package = "rchess")
pgn <- readLines(pgn, warn = FALSE)
pgn <- paste(pgn, collapse = "\n")
cat(pgn)
## [Event "Hoogovens A Tournament"]
## [Site "Wijk aan Zee NED"]
## [Date "1999.01.20"]
## [EventDate "?"]
## [Round "4"]
## [Result "1-0"]
## [White "Garry Kasparov"]
## [Black "Veselin Topalov"]
## [ECO "B06"]
## [WhiteElo "2812"]
## [BlackElo "2700"]
## [PlyCount "87"]
## 
## 1. e4 d6 2. d4 Nf6 3. Nc3 g6 4. Be3 Bg7 5. Qd2 c6 6. f3 b5
## 7. Nge2 Nbd7 8. Bh6 Bxh6 9. Qxh6 Bb7 10. a3 e5 11. O-O-O Qe7
## 12. Kb1 a6 13. Nc1 O-O-O 14. Nb3 exd4 15. Rxd4 c5 16. Rd1 Nb6
## 17. g3 Kb8 18. Na5 Ba8 19. Bh3 d5 20. Qf4+ Ka7 21. Rhe1 d4
## 22. Nd5 Nbxd5 23. exd5 Qd6 24. Rxd4 cxd4 25. Re7+ Kb6
## 26. Qxd4+ Kxa5 27. b4+ Ka4 28. Qc3 Qxd5 29. Ra7 Bb7 30. Rxb7
## Qc4 31. Qxf6 Kxa3 32. Qxa6+ Kxb4 33. c3+ Kxc3 34. Qa1+ Kd2
## 35. Qb2+ Kd1 36. Bf1 Rd2 37. Rd7 Rxd7 38. Bxc4 bxc4 39. Qxh8
## Rd3 40. Qa8 c3 41. Qa4+ Ke1 42. f4 f5 43. Kc1 Rd2 44. Qa7 1-0

chsspgn <- Chess$new()

chsspgn$load_pgn(pgn)
## [1] TRUE

cat(chsspgn$pgn())
## [Event "Hoogovens A Tournament"]
## [Site "Wijk aan Zee NED"]
## [Date "1999.01.20"]
## [EventDate "?"]
## [Round "4"]
## [Result "1-0"]
## [White "Garry Kasparov"]
## [Black "Veselin Topalov"]
## [ECO "B06"]
## [WhiteElo "2812"]
## [BlackElo "2700"]
## [PlyCount "87"]
## 
## 1. e4 d6 2. d4 Nf6 3. Nc3 g6 4. Be3 Bg7 5. Qd2 c6 6. f3 b5
## 7. Nge2 Nbd7 8. Bh6 Bxh6 9. Qxh6 Bb7 10. a3 e5 11. O-O-O Qe7
## 12. Kb1 a6 13. Nc1 O-O-O 14. Nb3 exd4 15. Rxd4 c5 16. Rd1 Nb6
## 17. g3 Kb8 18. Na5 Ba8 19. Bh3 d5 20. Qf4+ Ka7 21. Rhe1 d4
## 22. Nd5 Nbxd5 23. exd5 Qd6 24. Rxd4 cxd4 25. Re7+ Kb6
## 26. Qxd4+ Kxa5 27. b4+ Ka4 28. Qc3 Qxd5 29. Ra7 Bb7
## 30. Rxb7 Qc4 31. Qxf6 Kxa3 32. Qxa6+ Kxb4 33. c3+ Kxc3
## 34. Qa1+ Kd2 35. Qb2+ Kd1 36. Bf1 Rd2 37. Rd7 Rxd7
## 38. Bxc4 bxc4 39. Qxh8 Rd3 40. Qa8 c3 41. Qa4+ Ke1 42. f4 f5
## 43. Kc1 Rd2 44. Qa7 1-0

chsspgn$history()
##  [1] "e4"    "d6"    "d4"    "Nf6"   "Nc3"   "g6"    "Be3"   "Bg7"   "Qd2"  
## [10] "c6"    "f3"    "b5"    "Nge2"  "Nbd7"  "Bh6"   "Bxh6"  "Qxh6"  "Bb7"  
## [19] "a3"    "e5"    "O-O-O" "Qe7"   "Kb1"   "a6"    "Nc1"   "O-O-O" "Nb3"  
## [28] "exd4"  "Rxd4"  "c5"    "Rd1"   "Nb6"   "g3"    "Kb8"   "Na5"   "Ba8"  
## [37] "Bh3"   "d5"    "Qf4+"  "Ka7"   "Rhe1"  "d4"    "Nd5"   "Nbxd5" "exd5" 
## [46] "Qd6"   "Rxd4"  "cxd4"  "Re7+"  "Kb6"   "Qxd4+" "Kxa5"  "b4+"   "Ka4"  
## [55] "Qc3"   "Qxd5"  "Ra7"   "Bb7"   "Rxb7"  "Qc4"   "Qxf6"  "Kxa3"  "Qxa6+"
## [64] "Kxb4"  "c3+"   "Kxc3"  "Qa1+"  "Kd2"   "Qb2+"  "Kd1"   "Bf1"   "Rd2"  
## [73] "Rd7"   "Rxd7"  "Bxc4"  "bxc4"  "Qxh8"  "Rd3"   "Qa8"   "c3"    "Qa4+" 
## [82] "Ke1"   "f4"    "f5"    "Kc1"   "Rd2"   "Qa7"

chsspgn$history(verbose = TRUE)
## Source: local data frame [87 x 8]
## 
##    color  from    to flags piece   san captured number_move
##    (chr) (chr) (chr) (chr) (chr) (chr)    (chr)       (int)
## 1      w    e2    e4     b     p    e4       NA           1
## 2      b    d7    d6     n     p    d6       NA           2
## 3      w    d2    d4     b     p    d4       NA           3
## 4      b    g8    f6     n     n   Nf6       NA           4
## 5      w    b1    c3     n     n   Nc3       NA           5
## 6      b    g7    g6     n     p    g6       NA           6
## 7      w    c1    e3     n     b   Be3       NA           7
## 8      b    f8    g7     n     b   Bg7       NA           8
## 9      w    d1    d2     n     q   Qd2       NA           9
## 10     b    c7    c6     n     p    c6       NA          10
## ..   ...   ...   ...   ...   ...   ...      ...         ...
```

## Validation Functions

### State validation


```r
chss2 <- Chess$new("rnb1kbnr/pppp1ppp/8/4p3/5PPq/8/PPPPP2P/RNBQKBNR w KQkq - 1 3")
```


```r
plot(chss2)
```

<!--html_preserve--><div id="htmlwidget-2500" style="width:300px;height:300px;" class="chessboardjs"></div>
<script type="application/json" data-for="htmlwidget-2500">{"x":{"fen":"rnb1kbnr/pppp1ppp/8/4p3/5PPq/8/PPPPP2P/RNBQKBNR w KQkq - 1 3"},"evals":[]}</script><!--/html_preserve-->



```r
chss2$in_check()
## [1] TRUE

chss2$in_checkmate()
## [1] TRUE
```

### Slatemate validation


```r
chss3 <- Chess$new("4k3/4P3/4K3/8/8/8/8/8 b - - 0 78")

chss3$ascii()
##    +------------------------+
##  8 | .  .  .  .  k  .  .  . |
##  7 | .  .  .  .  P  .  .  . |
##  6 | .  .  .  .  K  .  .  . |
##  5 | .  .  .  .  .  .  .  . |
##  4 | .  .  .  .  .  .  .  . |
##  3 | .  .  .  .  .  .  .  . |
##  2 | .  .  .  .  .  .  .  . |
##  1 | .  .  .  .  .  .  .  . |
##    +------------------------+
##      a  b  c  d  e  f  g  h

chss3$in_stalemate()
## [1] TRUE
```

### Three fold repetition


```r
chss4 <- Chess$new("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")

chss4$in_threefold_repetition()
## [1] FALSE

chss4$move('Nf3')$move('Nf6')$move('Ng1')$move('Ng8')

chss4$in_threefold_repetition()
## [1] FALSE

chss4$move('Nf3')$move('Nf6')$move('Ng1')$move('Ng8')

chss4$in_threefold_repetition()
## [1] TRUE

chss4$history()
## [1] "Nf3" "Nf6" "Ng1" "Ng8" "Nf3" "Nf6" "Ng1" "Ng8"
```

### Insufficient material

```r
chess5 <- Chess$new("k7/8/n7/8/8/8/8/7K b - - 0 1")

plot(chess5, type = "ggplot")
```

<p><img src="index_files/figure-html/unnamed-chunk-14-1.png"> <aside></aside></p>

```r

chess5$insufficient_material()
## [1] TRUE
```

## Other (not from chessjs) Functions

Not all from the package is the wrapper for *chessjs*. There are some interesting functions.

### History Detail

This functions is a detailed version from the `history(verbose = TRUE)`.


```r
chsspgn$history_detail()
## Source: local data frame [92 x 8]
## 
##          piece  from    to number_move piece_number_move   status
##          (chr) (chr) (chr)       (int)             (int)    (chr)
## 1      a1 Rook    a1    d1          21                 1       NA
## 2      a1 Rook    d1    d4          29                 2       NA
## 3      a1 Rook    d4    d1          31                 3       NA
## 4      a1 Rook    d1    d4          47                 4 captured
## 5    b1 Knight    b1    c3           5                 1       NA
## 6    b1 Knight    c3    d5          43                 2 captured
## 7    c1 Bishop    c1    e3           7                 1       NA
## 8    c1 Bishop    e3    h6          15                 2 captured
## 9  White Queen    d1    d2           9                 1       NA
## 10 White Queen    d2    h6          17                 2       NA
## ..         ...   ...   ...         ...               ...      ...
## Variables not shown: number_move_capture (int), captured_by (chr)
```

We can check the final board status with the (last) fen and the
`history_detail` filtering by `status == "game over"`


```r
ggchessboard(chsspgn$fen())
```

<p><img src="index_files/figure-html/unnamed-chunk-16-1.png"> <aside></aside></p>

```r

library("dplyr")
## 
## Attaching package: 'dplyr'
## 
## The following objects are masked from 'package:stats':
## 
##     filter, lag
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
chsspgn$history_detail() %>% filter(status == "game over")
## Source: local data frame [11 x 8]
## 
##          piece  from    to number_move piece_number_move    status
##          (chr) (chr) (chr)       (int)             (int)     (chr)
## 1  White Queen    a4    a7          87                13 game over
## 2   White King    b1    c1          85                 3 game over
## 3      f2 Pawn    f3    f4          83                 2 game over
## 4      g2 Pawn    g2    g3          33                 1 game over
## 5      h2 Pawn    h2    NA          NA                 1 game over
## 6      b7 Pawn    c4    c3          80                 3 game over
## 7      f7 Pawn    f7    f5          84                 1 game over
## 8      g7 Pawn    g7    g6           6                 1 game over
## 9      h7 Pawn    h7    NA          NA                 1 game over
## 10     a8 Rook    d3    d2          86                 5 game over
## 11  Black King    d1    e1          82                12 game over
## Variables not shown: number_move_capture (int), captured_by (chr)
```


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
## R version 3.2.2 (2015-08-14)
## Platform: i386-w64-mingw32/i386 (32-bit)
## Running under: Windows 7 (build 7601) Service Pack 1
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
## [1] dplyr_0.4.3 rchess_0.1 
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.1         rstudioapi_0.3.1    knitr_1.11         
##  [4] magrittr_1.5        munsell_0.4.2       colorspace_1.2-6   
##  [7] R6_2.1.1            stringr_1.0.0       plyr_1.8.3         
## [10] tools_3.2.2         parallel_3.2.2      grid_3.2.2         
## [13] gtable_0.1.2        DBI_0.3.1           htmltools_0.2.6    
## [16] lazyeval_0.1.10     tufterhandout_1.2.2 yaml_2.1.13        
## [19] assertthat_0.1      digest_0.6.8        ggplot2_1.0.1.9003 
## [22] formatR_1.2.1       htmlwidgets_0.5     curl_0.9.3         
## [25] evaluate_0.8        rmarkdown_0.8.1     V8_0.9             
## [28] stringi_1.0-1       scales_0.3.0        jsonlite_0.9.17
```
