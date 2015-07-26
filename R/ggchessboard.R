#' @examples
#' ggchessboard(cellcols = c("#CCCCCC", "#FAFAFA"), piecesize = 17)
#'
#' ggchessboard(fen = "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2")
#'
#' ggchessboard(fen = "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2", perspective = "black")
#'
ggchessboard <- function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
                         cellcols = c("#D2B48C", "#F5F5DC"),
                         perspective = "white",
                         piecesize = 15){

  stopifnot(perspective %in% c("white", "black"))

  library("ggplot2")
  library("dplyr")

  dchess <- chessboarddata(fen = fen)

  str(dchess)

  lvls <- if (perspective == "white") 1:8 else 8:1

  dchess <- dchess %>%
    mutate(x = factor(x, levels = lvls),
           y = factor(y, levels = lvls))

  p <- ggplot(dchess, aes(x, y)) +
    geom_tile(aes(fill = cc)) + scale_fill_manual(values = cellcols) +
    geom_text(aes(label = text), size = piecesize) +
    coord_equal() + theme_null()

  p

}