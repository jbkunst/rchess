#' Plot a fen representation chessboard via ggplot2
#' @description Function to show the fen string in ggplot2.
#' @param fen Fen notation of a chessboard
#' @param cellcols A 2 length vector fot the cell colors
#' @param perspective A string to show the perspective (black, white)
#' @param piecesize Size of the the unicode texts
#' @param labelsize Size of the position indicators
#' @return A ggplot object
#' @export
#' @examples
#'
#' board <- ggchessboard()
#'
#' board <- ggchessboard(fen = "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2")
#'
#' board <- ggchessboard(fen = "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2",
#'              cellcols = c("#CCCCCC", "#FAFAFA"),
#'              piecesize = 17,
#'              perspective = "black")
#'
#' @export
ggchessboard <- function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
                         cellcols = c("#D2B48C", "#F5F5DC"),
                         perspective = "white",
                         piecesize = 15,
                         labelsize = 13){

  stopifnot(perspective %in% c("white", "black"))

  dchess <- .chessboarddata(fen = fen)

  lvls <- if (perspective == "white") 1:8 else 8:1

  dchess <- dchess |>
    dplyr::mutate(
      x = factor(.data$x, levels = lvls),
      y = factor(.data$y, levels = lvls)
    )

  p <- ggplot2::ggplot(dchess, ggplot2::aes(x = .data$x, y = .data$y)) +
    ggplot2::geom_tile(ggplot2::aes(fill = .data$cc)) +
    ggplot2::geom_text(ggplot2::aes(label = .data$text), size = piecesize) +
    ggplot2::scale_fill_manual(values = cellcols) +
    ggplot2::coord_equal() +
    ggplot2::theme(
      legend.position = "none",
      panel.background = ggplot2::element_blank(),
      axis.ticks = ggplot2::element_blank(),
      axis.text = ggplot2::element_text(size = labelsize)
    ) +
    ggplot2::scale_x_discrete(labels = letters[1:8]) +
    ggplot2::labs(x = "", y = "")

  p

}
