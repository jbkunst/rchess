from <- to <- number_move <- NULL
#' Chess Class
#'
#' Chees class.
#' @docType class
#' @import R6 dplyr
#' @format An \code{\link{R6Class}} generator object
#' @section Methods:
#' \itemize{
#'   \item{\code{new}} Creating a new instance of Chess class.
#'   \item{\code{ascii}} Print the board via console.
#'   \item{\code{clear}} Remove all pieces from the board.
#'   \item{\code{fen}} Return the actual Forsyth Edwards notation.
#'   \item{\code{pgn}} Return Portable Game notation.
#'   \item{\code{get}} Return the piece in a spicific square argument.
#'   \item{\code{history}} Return a vector containing the moves of the current game. If the
#'        argument \code{verbose=TRUE} is added the method return a data frame.
#'   \item{\code{game_over}} Returns TRUE if the game has ended via checkmate, stalemate,
#'        draw, threefold repetition, or insufficient material. Otherwise, returns FALSE.
#'   \item{\code{in_check}} Returns true or false if the side to move is in check.
#'   \item{\code{in_checkmate}} Returns true or false if the side to move has been checkmated.
#'   \item{\code{in_draw}} Returns true or false if the game is drawn 50 move rule or insufficient material.
#'   \item{\code{in_stalemate}} Returns true or false if the side to move has been stalemated.
#'   \item{\code{in_threefold_repetition}} Returns true or false if the current board position has occurred three or more times.
#'   \item{\code{insufficient_material}} Returns true if the game is drawn due to insufficient material (K vs. K, K vs. KB, or K vs. KN); otherwise false.
#'   \item{\code{move}} Attempts to make a move on the board, returning a move object
#'        if the move was legal, otherwise null. The .move function can be called two ways,
#'        by passing a string in Standard Algebraic Notation SAN:
#'   \item{\code{moves}} Returns a vector of legals moves from the current position.
#'        The function takes an optional parameter which controls the single square move generation and verbosity.
#'   \item{\code{validate_fen}} Returns a validation object specifying validity or the errors found within the FEN string.
#'   \item{\code{load}}
#'   \item{\code{load_pgn}} Load the moves of a game stored in Portable Game Notation.
#'   \item{\code{put}} Place a piece on square where piece is an object.
#'   \item{\code{remove}} Remove and return the piece on square.
#'   \item{\code{reset}} Reset the board to the initial starting position.
#'   \item{\code{square_color}} Returns the color of the square (light or dark).
#'   \item{\code{turn}} Returns the current side to move.
#'   \item{\code{undo}} Takeback the last halfmove, returning a move object if successful.
#'   \item{\code{header}} Allows header information to be added to PGN output.
#'        Any number of key value pairs can be passed to \code{header()}.
#'   \item{\code{history_detail}} Return a detailed version for \code{history(verbose=TRUE)}.
#'   \item{\code{summary}} Print a summary of the object.
#'   \item{\code{plot}} Plot the object via chessboarjs. You can add \code{type} {ggplot}.
#'   \item{\code{print}} Print the summary ob the Chess object.
#' }
#' @export
Chess <- R6::R6Class(
  "Chess",
  private = list(
    ct = NULL
  ),
  public = list(
    initialize = function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1") {
      stopifnot(is_valid_fen(fen))
      self$init_ct(fen)
      invisible(self)
    },
    init_ct = function(fen){
      private$ct <- .get_context_chess_from_fen(fen)
    },
    ### chessjs api
    ascii = function(){
      cat(private$ct$get("chess.ascii()"))
    },
    clear = function(){
      private$ct$eval(V8::JS("chess.clear()"))
    },
    fen = function(){
      private$ct$get(V8::JS("chess.fen()"))
    },
    pgn = function(){
      private$ct$get("chess.pgn({ max_width: 60 })")
    },
    get = function(square){
      assertthat::assert_that(is_chess_square(square))
      strg <- sprintf("chess.get('%s')", square)
      private$ct$get(V8::JS(strg))
    },
    history = function(verbose = FALSE){
      private$ct$assign("verb", verbose)
      res <- private$ct$get("chess.history({ verbose: verb })")
      if (verbose) res <- dplyr::tbl_df(res) %>% mutate(number_move = seq(nrow(.)))
      res
    },
    game_over = function(){
      private$ct$get(V8::JS("chess.game_over()"))
    },
    in_check = function(){
      private$ct$get(V8::JS("chess.in_check()"))
    },
    in_checkmate = function(){
      private$ct$get(V8::JS("chess.in_checkmate()"))
    },
    in_draw = function(){
      private$ct$get(V8::JS("chess.in_draw()"))
    },
    in_stalemate = function(){
      private$ct$get(V8::JS("chess.in_stalemate()"))
    },
    in_threefold_repetition = function(){
      private$ct$get(V8::JS("chess.in_threefold_repetition()"))
    },
    insufficient_material = function(){
      private$ct$get(V8::JS("chess.insufficient_material()"))
    },
    move = function(move){
      assertthat::assert_that(is_valid_move(move, self$moves()))
      strg <- sprintf("chess.move('%s')", move)
      private$ct$eval(V8::JS(strg))
      # return invisible(self) to concatenate moves
      invisible(self)
    },
    moves = function(verbose = FALSE){
      private$ct$assign("verb", verbose)
      res <- private$ct$get("chess.moves({ verbose: verb })")
      if (verbose) res <- dplyr::tbl_df(res)
      res
    },
    validate_fen = function(fen){
      stopifnot((is_valid_fen(fen)))
      private$ct$assign("fen", fen)
      private$ct$get("chess.validate_fen(fen)")
    },
    load = function(fen){
      stopifnot((is_valid_fen(fen)))
      private$ct$assign("fen", fen)
      private$ct$get("chess.load(fen)")
    },
    load_pgn = function(pgn){
      assertthat::is.string(pgn)
      private$ct$assign("pgn", pgn)
      private$ct$get("chess.load_pgn(pgn)")
    },
    put = function(type, color, square){
      assertthat::assert_that(is_chess_square(square))
      assertthat::assert_that(color %in% c("w", "b"))
      assertthat::assert_that(type %in% c("k", "q", "p", "n", "r", "b"))
      private$ct$assign("type", type)
      private$ct$assign("color", color)
      private$ct$assign("square", square)
      private$ct$get("chess.put({ type: type, color: color }, square)")
    },
    remove = function(square){
      assertthat::assert_that(is_chess_square(square))
      strg <- sprintf("chess.remove('%s')", square)
      private$ct$get(strg)
    },
    reset = function(){
      private$ct$eval("chess.reset();")
    },
    square_color = function(square){
      assertthat::assert_that(is_chess_square(square))
      strg <- sprintf("chess.square_color('%s')", square)
      private$ct$get(V8::JS(strg))
    },
    turn = function(){
      private$ct$get(V8::JS("chess.turn()"))
    },
    undo = function(){
      private$ct$get(V8::JS("chess.undo()"))
    },
    header = function(key, value){
      private$ct$assign("key", key)
      private$ct$assign("value", value)
      private$ct$eval("chess.header(key, value)")
      invisible(self)
    },
    #### internals
    history_detail = function(){
      resp <- .history_detail(self$history(verbose = TRUE))
      resp
    },
    #### generic methods
    summary = function(){

      cat("\nTurn\n")
      cat(self$turn())

      cat("\n\nNumber of moves\n")
      cat(length(self$history()))

      cat("\n\nHistory\n")
      cat(self$history())

      cat("\n\nFen representation\n")
      cat(self$fen())

      cat("\n\nBoard\n")
      cat(self$ascii())

      },
    plot    = function(type = "chessboardjs", ...){
      stopifnot(type %in% c("chessboardjs", "ggplot"))
      if (type == "ggplot") e <- ggchessboard(self$fen(), ...)
      if (type == "chessboardjs") e <- chessboardjs(self$fen(), ...)
      e
    },
    print   = function(){
      self$summary()
    }))

.get_context_chess_from_fen <- function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1") {
  ct <- V8::new_context();
  ct$source(system.file("htmlwidgets/lib/chess.min.js", package = "rchess"))
  ct$assign("fen", fen)
  ct$assign("chess", V8::JS("new Chess(fen);"))
  ct
}

.add_castlings_rows_to_history <- function(dfhist) {
  # check if there are castlings
  if (nrow(dfhist %>% filter_("color == \"w\"", "san == \"O-O\"")) == 1) {
    row <- (dfhist %>% filter_("color == \"w\"", "san == \"O-O\""))[["number_move"]]
    dfhist <- plyr::rbind.fill(
      dfhist[1:row, ],
      data_frame(color = "w", from = "h1", to = "f1", flags = "r",
                 piece = "r", san = "O-O", captured = NA, number_move = row),
      dfhist[(row + 1):nrow(dfhist), ])
  }
  if (nrow(dfhist %>% filter_("color == \"w\"", "san == \"O-O-O\"")) == 1) {
    row <- (dfhist %>% filter_("color == \"w\"", "san == \"O-O-O\""))[["number_move"]]
    dfhist <- plyr::rbind.fill(
      dfhist[1:row, ],
      data_frame(color = "w", from = "a1", to = "d1", flags = "r",
                 piece = "r", san = "O-O-O", captured = NA, number_move = row),
      dfhist[(row + 1):nrow(dfhist), ])
  }
  if (nrow(dfhist %>% filter_("color == \"b\"", "san == \"O-O\"")) == 1) {
    row <- (dfhist %>% filter_("color == \"b\"", "san == \"O-O\""))[["number_move"]]
    dfhist <- plyr::rbind.fill(
      dfhist[1:row, ],
      data_frame(color = "b", from = "h8", to = "f8", flags = "r",
                 piece = "r", san = "O-O", captured = NA, number_move = row),
      dfhist[(row + 1):nrow(dfhist), ])
  }
  if (nrow(dfhist %>% filter_("color == \"b\"", "san == \"O-O-O\"")) == 1) {
    row <- (dfhist %>% filter_("color == \"b\"", "san == \"O-O-O\""))[["number_move"]]
    dfhist <- plyr::rbind.fill(
      dfhist[1:row, ],
      data_frame(color = "b", from = "a8", to = "d8", flags = "r",
                 piece = "r", san = "O-O-O", captured = NA, number_move = row),
      dfhist[(row + 1):nrow(dfhist), ])
  }

  dfhist <- tbl_df(dfhist)

  dfhist
}

#' @importFrom graphics text
#' @importFrom stats na.omit
#' @importFrom utils head
.history_detail <- function(dfhist) {

  dfhist <- .add_castlings_rows_to_history(dfhist)

  start_positions <- c(paste0(letters[seq(8)], 8),
                       paste0(letters[seq(8)], 7),
                       paste0(letters[seq(8)], 2),
                       paste0(letters[seq(8)], 1))

  df_start_positions <- data_frame("start_position" = start_positions)

  names(start_positions) <- start_positions

  df_paths <- plyr::ldply(start_positions,  function(start_position = "g1", dfhist) {
    # start_position <- "g1"
    pos_current <- start_position
    pos_nummove <- 0
    piece_was_captured <- FALSE
    game_is_over <- FALSE

    df_path <- NULL

    while (!piece_was_captured & !game_is_over) {

      dfhist_aux <- dfhist %>%
        filter(from == pos_current | to == pos_current,
               number_move > pos_nummove) %>%
        head(1)

      # game is over?
      if (nrow(dfhist_aux) == 0) {
        game_is_over <- TRUE

        if (is.null(nrow(df_path))) {
          df_path <- data_frame(from = pos_current, status = "game over")
        } else {
          df_path <- df_path %>% mutate(status = c(rep(NA, nrow(df_path) - 1), "game over"))
        }

        break
      }

      # pieces was captured
      if (dfhist_aux$to == pos_current) {
        piece_was_captured <- TRUE

        if (is.null(nrow(df_path))) {
          df_path <- data_frame(from = pos_current,
                                status = "captured",
                                number_move_capture = dfhist_aux$number_move)
        } else {
          df_path <- df_path %>%
            mutate(status = c(rep(NA, nrow(df_path) - 1), "captured"),
                   number_move_capture = c(rep(NA, nrow(df_path) - 1), dfhist_aux$number_move))
        }

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
  df_paths <- tbl_df(df_paths) %>% rename_("start_position" = ".id")

  # calculating moves per pieces
  df_paths <- df_paths %>%
    group_by_("start_position") %>%
    mutate(piece_number_move = row_number()) %>%
    ungroup() %>%
    arrange_("start_position")

  df_paths <- full_join(.chesspiecedata() %>% select_("piece" = "name", "start_position"),
                        df_paths,
                        by = "start_position")

  df_paths <- cbind(df_paths %>% select_("-start_position", "-status", "-number_move_capture"),
                    df_paths %>% select_("status", "number_move_capture"))

  df_paths <- tbl_df(df_paths)

  # adding the pieces was capture the others
  df_caputre <- df_paths %>%
    filter(number_move %in% na.omit(df_paths$number_move_capture)) %>%
    select_("captured_by" = "piece", "number_move_capture" = "number_move")

  df_paths <- df_paths %>%
    left_join(df_caputre, by = "number_move_capture")

  df_paths

}

#' @export
summary.Chess <- function(object, ...) {
  object$summary()
}

#' @export
plot.Chess <- function(x, y=NULL, ...) {
  x$plot(...)
}

#' @export
print.Chess <- function(x, ...) {
  x$print()
}
