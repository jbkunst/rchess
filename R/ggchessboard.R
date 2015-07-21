#' @examples
#' ggchessboard()
#' ggchessboard(fen = "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2", c("#CCCCCC", "#FAFAFA"))
#'
ggchessboard <- function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
                         cellcols = c("#D2B48C", "#F5F5DC")){

  library("ggplot2")

  dchess <- chessboarddata(fen = fen)

  ggplot(dchess) +
    geom_tile(aes(col, row, fill = cc)) +
    scale_fill_manual(values = cellcols) +
    coord_equal() +
    theme_null() +
    geom_text(aes(col, row, label = text), size = 10)

}