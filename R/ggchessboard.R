x <- y <- NULL
#' Plot a fen representation chessboard via ggplot2
#' @description Function to show the fen string in ggplot2.
#' @param fen Fen notation of a chessboard
#' @param cellcols A 2 length vector fot the cell colors
#' @param perspective A string to show the perspective (black, white)
#' @param piecesize Size of the the unicode texts
#' @return A ggplot object
#' @import ggplot2
#' @export
#' @examples
#'
#' ggchessboard()
#'
#' ggchessboard(fen = "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2")
#'
#' ggchessboard(fen = "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2",
#'              cellcols = c("#CCCCCC", "#FAFAFA"),
#'              piecesize = 17,
#'              perspective = "black")
#'
#' @export
ggchessboard <- function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
                         cellcols = c("#D2B48C", "#F5F5DC"),
                         perspective = "white",
                         piecesize = 15){

  stopifnot(perspective %in% c("white", "black"))

  dchess <- .chessboarddata(fen = fen)

  lvls <- if (perspective == "white") 1:8 else 8:1

  dchess <- dchess %>%
    dplyr::mutate(x = factor(x, levels = lvls),
                  y = factor(y, levels = lvls))

  p <- ggplot(dchess, aes_string("x", "y")) +
    geom_tile(aes_string(fill = "cc")) +
    geom_text(aes_string(label = "text"), size = piecesize) +
    scale_fill_manual(values = cellcols) +
    coord_equal() +
    theme(legend.position = "none", panel.background = element_blank()) +
    scale_x_discrete(labels = letters[1:8])
    labs(x = "", y = "")

  p

}
