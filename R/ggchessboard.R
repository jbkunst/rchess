x <- y <- NULL
#' Plot a chessboard via ggplot2
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
#' \dontrun{
#' ggchessboard()
#'
#' ggchessboard(fen = "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2")
#'
#' ggchessboard(fen = "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2",
#'              cellcols = c("#CCCCCC", "#FAFAFA"),
#'              piecesize = 17,
#'              perspective = "black")
#'}
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
    dplyr::mutate_(x = factor(x, levels = lvls),
                   y = factor(y, levels = lvls))

  p <- ggplot(dchess, aes_string("x", "y")) +
    geom_tile(aes_string(fill = "cc")) +
    geom_text(aes_string(label = "text"), size = piecesize) +
    scale_fill_manual(values = cellcols) +
    coord_equal() +
    ggthemes::theme_map() +
    theme(legend.position = "none")

  p

}

#' @import magrittr
.chessboarddata <- function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"){

  rows <- seq(8)
  cols <- letters[rows]

  pieces <- c(P = "\u2659", p = "\u265F",
              K  = "\u2654", k = "\u265A",
              Q  = "\u2655", q = "\u265B",
              R  = "\u2656", r = "\u265C",
              B  = "\u2657", b = "\u265D",
              N  = "\u2658", n = "\u265E")

  dpieces <- dplyr::data_frame(piece = names(pieces),
                               text = pieces)

  dchess <- dplyr::data_frame(idcell = seq(64),
                              col    = rep(cols, times = 8),
                              row    = rep(seq(8), each = 8),
                              x      = rep(rows, times = 8),
                              y      = rep(seq(8), each = 8),
                              cell   = paste0(col, row),
                              cc     = ifelse((x + y) %% 2, "w", "b"))

  dfen <- dplyr::data_frame(idcell = rep(seq(8), 8) + rep(7:0, each = 8)*8,
                            piece  = .parse_fen(fen))

  dchess <- dchess %>%
    dplyr::left_join(dfen, by = "idcell") %>%
    dplyr::left_join(dpieces, by = "piece")

  dchess <- dchess %>%
    dplyr::mutate(text = ifelse(is.na(text), "", text))

  dchess

}


.parse_fen <- function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"){

  fen <- strsplit(fen, "\\s")[[1]][[1]]
  fen <- unlist(strsplit(fen, "/"))
  fen <- unlist(setdiff(paste0(fen, collapse = ""), ""))

  for (i in seq(8))
    fen <- gsub(i, paste0(rep(" ", i), collapse = ""), fen)


  fen <- unlist(strsplit(fen, ""))

  stopifnot(length(fen) == 64)

  fen
}