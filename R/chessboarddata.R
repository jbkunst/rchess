chessboarddata <- function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"){
  library("dplyr")

  rows <- seq(8)
  cols <- letters[rows]

  pieces <- c(P = "\u2659", p = "\u265F",
              K  = "\u2654", k = "\u265A",
              Q  = "\u2655", q = "\u265B",
              R  = "\u2656", r = "\u265C",
              B  = "\u2657", b = "\u265D",
              N  = "\u2658", n = "\u265E")

  dpieces <- data_frame(piece = names(pieces),
                        text = pieces)

  dchess <- data_frame(idcell = seq(64),
                       col    = rep(cols, times = 8),
                       row    = rep(seq(8), each = 8),
                       x      = rep(rows, times = 8),
                       y      = rep(seq(8), each = 8),
                       cell   = paste0(col, row),
                       cc     = ifelse((x + y) %% 2, "w", "b"))

  dfen <- data_frame(idcell = rep(seq(8), 8) + rep(7:0, each = 8)*8,
                     piece  = parse_fen(fen))

  dchess <- dchess %>%
    left_join(dfen, by = "idcell") %>%
    left_join(dpieces, by = "piece")

  dchess <- dchess %>%
    mutate(text = ifelse(is.na(text), "", text))

  dchess

}


parse_fen <- function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"){
  fen <- strsplit(fen, "\\s")[[1]][[1]]
  fen <- unlist(strsplit(fen, "/"))
  fen <- unlist(setdiff(paste0(fen, collapse = ""), ""))

  for (i in seq(8))
    fen <- gsub(i, paste0(rep(" ", i), collapse = ""), fen)


  fen <- unlist(strsplit(fen, ""))

  stopifnot(length(fen) == 64)

  fen
}
