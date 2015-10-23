#' @import dplyr
.chesspiecedata <- function() {

  start_position <- c(
    paste0(letters[seq(8)], 1),
    paste0(letters[seq(8)], 2),
    paste0(letters[seq(8)], 7),
    paste0(letters[seq(8)], 8))

  name_long <- c(
    "White's Queen's Rook", "White's Queen's Knight", "White's Queen's Bishop", "White's Queen",
    "White's King", "White's King's Bishop", "White's King's Knight", "White's King's Rook",
    "White's Queen's Rook's Pawn", "White's Queen's Knight's Pawn", "White's Queen's Bishop's Pawn", "White's Queen's Pawn",
    "White's King's Pawn", "White's King's Bishop's Pawn", "White's King's Knight's Pawn", "White's King's Rook's Pawn",
    "Black's Queen's Rook's Pawn", "Black's Queen's Knight's Pawn", "Black's Queen's Bishop's Pawn", "Black's Queen's Pawn",
    "Black's King's Pawn", "Black's King's Bishop's Pawn", "Black's King's Knight's Pawn", "Black's King's Rook's Pawn",
    "Black's Queen's Rook", "Black's Queen's Knight", "Black's Queen's Bishop", "Black's Queen",
    "Black's King'", "Black's King's Bishop", "Black's King's Knight", "Black's King's Rook")

  name <- c(
    "a1 Rook", "b1 Knight", "c1 Bishop", "White Queen",
    "White King", "f1 Bishop", "g1 Knight", "h1 Rook",
    "a2 Pawn", "b2 Pawn", "c2 Pawn", "d2 Pawn", "e2 Pawn", "f2 Pawn", "g2 Pawn", "h2 Pawn",
    "a7 Pawn", "b7 Pawn", "c7 Pawn", "d7 Pawn", "e7 Pawn", "f7 Pawn", "g7 Pawn", "h7 Pawn",
    "a8 Rook", "b8 Knight", "c8 Bishop", "Black Queen",
    "Black King", "f8 Bishop", "g8 Knight", "h8 Rook")

  fen <- c(
    "R", "N", "B", "Q",
    "K", "B", "N", "R",
    "P", "P", "P", "P", "P", "P", "P", "P",
    "p", "p", "p", "p", "p", "p", "p", "p",
    "r", "n", "b", "q",
    "k", "b", "n", "r")

  unicode <- c(P = "\u2659", p = "\u265F",
               K  = "\u2654", k = "\u265A",
               Q  = "\u2655", q = "\u265B",
               R  = "\u2656", r = "\u265C",
               B  = "\u2657", b = "\u265D",
               N  = "\u2658", n = "\u265E")

  dfpieces <- data_frame(
    fen,
    start_position,
    name,
    name_long,
    color = c(rep("w", 16), rep("b", 16))) %>%
    left_join(data_frame(fen = names(unicode),
                         unicode = unicode), by = "fen") %>%
    mutate(name_short = paste(fen, start_position))

  dfpieces

}

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