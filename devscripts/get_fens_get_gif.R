# function to get fens from a pgn game.
library("rchess")
library("magrittr")
library("purrr")

get_fens <- function(pgn) {

  chss <- Chess$new()
  chss$load_pgn(pgn)

  moves <- chss$history()
  chss$reset()

  fens <- map_chr(moves, function(x) chss$move(x)$fen())

  fens

}

data("chesswc")
game <- head(chesswc,1)
pgn <- game$pgn

fens <- get_fens(pgn)

player <- "white"
move <- 11
gamemove <- 2 * move + (player != "white")

fens[gamemove]
ggchessboard(fens[gamemove])


library("magick")
get_gif <- function(pgn, scale = "400x400", fps = 1) {

  fens <- get_fens(pgn)
  # fens <- head(fens)

  fens %>%
    map(ggchessboard) %>%
    map_chr(function(p){ # p <- sample(plots, size = 1)[[1]]
    fl <- tempfile(fileext = ".jpg")
    ggplot2::ggsave(p, file = fl)
    fl
  }) %>%
    image_read() %>%
    image_scale(geometry = scale) %>%
    image_animate(fps = fps)


}

gif <- get_gif(pgn)

image_write(gif, "devscripts/anim.gif")




