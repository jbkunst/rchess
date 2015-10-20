library("rchess")
library("dplyr")
library("ggplot2")


rm(list = ls())
pgn <- system.file("extdata/pgn/kasparov_vs_topalov.pgn", package = "rchess")
pgn <- readLines(pgn, warn = FALSE)
pgn <- paste(pgn, collapse = "\n")
cat(pgn)


chsspgn <- Chess$new()
chsspgn$load_pgn(pgn)
plot(chsspgn)

dfhist <- chsspgn$history(verbose = TRUE)

rm(chsspgn, pgn)

pieces_path <- function(dfhist) {

  start_positions <- c(paste0(letters[seq(8)], 8),
                       paste0(letters[seq(8)], 7),
                       paste0(letters[seq(8)], 2),
                       paste0(letters[seq(8)], 1))

  df_start_positions <- data_frame(start_position = start_positions)

  names(start_positions) <- start_positions

  df_paths <- plyr::ldply(start_positions,  function(start_position = "g1", dfhist) {
    # start_position <- "g1"
    pos_current <- start_position
    pos_nummove <- 0
    piece_was_captured <- FALSE
    game_is_over <- FALSE

    df_path <- NULL

    while(!piece_was_captured & !game_is_over) {

      dfhist_aux <- dfhist %>%
        filter(from == pos_current | to == pos_current,
               number_move > pos_nummove) %>%
        head(1)

      if (nrow(dfhist_aux) == 0){
        game_is_over <- TRUE
        break
      }

      if (dfhist_aux$to == pos_current){
        piece_was_captured <- TRUE
        break
      }

      df_path <- rbind(df_path,
                       data_frame(from = pos_current,
                                  to = dfhist_aux$to,
                                  number_move = dfhist_aux$number_move))

      pos_current <- dfhist_aux$to
      pos_nummove <- dfhist_aux$number_move

    }

    df_path

  }, dfhist)

  # rename id var
  df_paths <- tbl_df(df_paths) %>% rename(start_position = .id)

  # count(df_paths, start_position)

  # calculating moves per pieces
  df_paths <- df_paths %>%
    group_by(start_position) %>%
    mutate(piece_number_move = row_number()) %>%
    ungroup() %>%
    arrange(start_position)

  pieces_no_hist <- start_positions[which(!start_positions %in% df_paths$start_position)]

  df_paths <- plyr::rbind.fill(df_paths, data_frame(start_position = pieces_no_hist))

  df_paths <- df_paths %>%
    mutate(start_position = factor(start_position, levels = start_positions))

  df_paths <- df_paths %>% arrange(start_position) %>% tbl_df()

  df_paths

}

pieces_path(dfhist)

pieces_path(dfhist) %>%
  ggplot() +
  geom_density(aes(number_move)) +
  facet_wrap(~start_position, nrow = 4)

summary <- pieces_path(dfhist) %>%
  group_by(start_position) %>%
  summarise(first_move = min(number_move),
            moves = max(piece_number_move)) %>%
  arrange(start_position)

View(summary)



.chesspiecedata <- function() {

  name_long <- c(
    "White's Queen's Rook", "White's Queen's Knight", "White's Queen's Bishop", "White's Queen",
    "White's King", "White's King's Bishop", "White's King's Knight", "White's King's Rook",
    "White's Queen's Rook's Pawn", "White's Queen's Knight's Pawn", "White's Queen's Bishop's Pawn", "White's Queen's Pawn",
    "White's King's Pawn", "White's King's Bishop's Pawn", "White's King's Knight's Pawn", "White's King's Rook's Pawn",
    "Black's Queen's Rook's Pawn", "Black's Queen's Knight's Pawn", "Black's Queen's Bishop's Pawn", "Black's Queen's Pawn",
    "Black's King's Pawn", "Black's King's Bishop's Pawn", "Black's King's Knight's Pawn", "Black's King's Rook's Pawn",
    "Black's Queen's Rook", "Black's Queen's Knight", "Black's Queen's Bishop", "Black's Queen",
    "Black's King'", "Black's King's Bishop", "Black's King's Knight", "Black's King's Rook")

  name_short <- c(
    "a1 Rook", "b1 Knight", "c3 Bishop", "White Queen",
    "White King", "f1 Bishop", "g1 Knight", "h1 Rook",
    "a2 Pawn", "b2 Pawn", "c2 Pawn", "d2 Pawn", "e2 Pawn", "f2 Pawn", "q2 Pawn", "h2 Pawn",
    "a7 Pawn", "b7 Pawn", "c7 Pawn", "d7 Pawn", "e7 Pawn", "f7 Pawn", "q7 Pawn", "h7 Pawn",
    "a8 Rook", "b8 Knight", "c8 Bishop", "Black Queen",
    "Black King", "f8 Bishop", "g8 Knight", "h8 Rook")

  pieces <- rchess:::.chessboarddata() %>%
    filter(text != "") %>%
    select(piece, text, cell) %>%
    rename(unicode = text, start_position = cell) %>%
    mutate(color = ifelse(piece == toupper(piece), "white", "black"),
           name_long = name_long,
           name_short)

  pieces

}
