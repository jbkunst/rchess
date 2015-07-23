#' @examples
#' ggchessboard()
#' p <- ggchessboard(fen = "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2", c("#CCCCCC", "#FAFAFA"))
#'
#' ggchessboard(fen = "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2", perspective = "black")
#'
ggchessboard <- function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
                         cellcols = c("#D2B48C", "#F5F5DC"),
                         perspective = "white"){

  stopifnot(perspective %in% c("white", "black"))

  library("ggplot2")

  dchess <- chessboarddata(fen = fen)

  p <- ggplot(dchess, aes(x, y))

  p <- p +
    geom_tile(aes(fill = cc)) + scale_fill_manual(values = cellcols) +
    geom_text(aes(label = text), size = 10)

#
#   if (perspective == "black") {
#     p <- p + scale_x_reverse()
#   }

  p <- p + coord_equal() + theme_null()

}