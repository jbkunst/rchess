#' Chess Class
#'
#' Chees class.
#' @docType class
#' @import R6
#' @format An [R6::R6Class] generator object.
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
#'   \item{\code{get_header}} Get header of the actual game via list object.
#'   \item{\code{history_detail}} Return a detailed version for \code{history(verbose=TRUE)}.
#'   \item{\code{summary}} Print a summary of the object.
#'   \item{\code{plot}} Plot the object with chessboard.js or ggplot2.
#'   \item{\code{print}} Print the summary ob the Chess object.
#' }
#' @export
Chess <- R6::R6Class(
  "Chess",
  private = list(
    ct = NULL
  ),
  public = list(
    #' @description Create a game from a FEN position.
    #' @param fen A Forsyth-Edwards Notation string.
    initialize = function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1") {
      stopifnot(is_valid_fen(fen))
      self$init_ct(fen)
      invisible(self)
    },
    #' @description Initialize the underlying JavaScript chess context.
    #' @param fen A Forsyth-Edwards Notation string.
    init_ct = function(fen){
      private$ct <- .get_context_chess_from_fen(fen)
    },
    ### chessjs api
    #' @description Print an ASCII representation of the board.
    ascii = function(){
      cat(private$ct$get("chess.ascii()"))
    },
    #' @description Remove all pieces from the board.
    clear = function(){
      private$ct$eval(V8::JS("chess.clear()"))
    },
    #' @description Return the current FEN position.
    fen = function(){
      private$ct$get(V8::JS("chess.fen()"))
    },
    #' @description Return the game in Portable Game Notation.
    pgn = function(){
      private$ct$get("chess.pgn({ max_width: 60 })")
    },
    #' @description Return the piece on a square.
    #' @param square A square such as `"e4"`.
    get = function(square){
      assertthat::assert_that(is_chess_square(square))
      strg <- sprintf("chess.get('%s')", square)
      private$ct$get(V8::JS(strg))
    },
    #' @description Return the moves already played.
    #' @param verbose If `TRUE`, return detailed move records as a tibble.
    history = function(verbose = FALSE){
      private$ct$assign("verb", verbose)
      res <- private$ct$get("chess.history({ verbose: verb })")
      if (verbose) {
        res <- tibble::as_tibble(res)
        res <- dplyr::mutate(res, number_move = seq_len(nrow(res)))
      }
      res
    },
    #' @description Test whether the game has ended.
    game_over = function(){
      private$ct$get(V8::JS("chess.game_over()"))
    },
    #' @description Test whether the active player is in check.
    in_check = function(){
      private$ct$get(V8::JS("chess.in_check()"))
    },
    #' @description Test whether the active player is checkmated.
    in_checkmate = function(){
      private$ct$get(V8::JS("chess.in_checkmate()"))
    },
    #' @description Test whether the game is drawn.
    in_draw = function(){
      private$ct$get(V8::JS("chess.in_draw()"))
    },
    #' @description Test whether the active player is stalemated.
    in_stalemate = function(){
      private$ct$get(V8::JS("chess.in_stalemate()"))
    },
    #' @description Test whether the position has repeated three times.
    in_threefold_repetition = function(){
      private$ct$get(V8::JS("chess.in_threefold_repetition()"))
    },
    #' @description Test whether neither player has mating material.
    insufficient_material = function(){
      private$ct$get(V8::JS("chess.insufficient_material()"))
    },
    #' @description Play a legal move.
    #' @param move A move in Standard Algebraic Notation.
    move = function(move){
      assertthat::assert_that(is_valid_move(x = move, mvs = self$moves()))
      strg <- sprintf("chess.move('%s')", move)
      private$ct$eval(V8::JS(strg))
      # return invisible(self) to concatenate moves
      invisible(self)
    },
    #' @description Return legal moves from the current position.
    #' @param verbose If `TRUE`, return detailed move records as a tibble.
    moves = function(verbose = FALSE){
      private$ct$assign("verb", verbose)
      res <- private$ct$get("chess.moves({ verbose: verb })")
      if (verbose) res <- tibble::as_tibble(res)
      res
    },
    #' @description Validate a FEN position.
    #' @param fen A Forsyth-Edwards Notation string.
    validate_fen = function(fen){
      stopifnot((is_valid_fen(fen)))
      private$ct$assign("fen", fen)
      private$ct$get("chess.validate_fen(fen)")
    },
    #' @description Replace the current position with a FEN position.
    #' @param fen A Forsyth-Edwards Notation string.
    load = function(fen){
      stopifnot((is_valid_fen(fen)))
      private$ct$assign("fen", fen)
      private$ct$get("chess.load(fen)")
    },
    #' @description Load a game from Portable Game Notation.
    #' @param pgn A Portable Game Notation string.
    load_pgn = function(pgn){
      assertthat::is.string(pgn)
      private$ct$assign("pgn", pgn)
      private$ct$get("chess.load_pgn(pgn)")
    },
    #' @description Place a piece on a square.
    #' @param type One of `"k"`, `"q"`, `"r"`, `"b"`, `"n"`, or `"p"`.
    #' @param color Either `"w"` or `"b"`.
    #' @param square A square such as `"e4"`.
    put = function(type, color, square){
      assertthat::assert_that(is_chess_square(square))
      assertthat::assert_that(color %in% c("w", "b"))
      assertthat::assert_that(type %in% c("k", "q", "p", "n", "r", "b"))
      private$ct$assign("type", type)
      private$ct$assign("color", color)
      private$ct$assign("square", square)
      private$ct$get("chess.put({ type: type, color: color }, square)")
    },
    #' @description Remove and return the piece on a square.
    #' @param square A square such as `"e4"`.
    remove = function(square){
      assertthat::assert_that(is_chess_square(square))
      strg <- sprintf("chess.remove('%s')", square)
      private$ct$get(strg)
    },
    #' @description Reset the game to the standard starting position.
    reset = function(){
      private$ct$eval("chess.reset();")
    },
    #' @description Return whether a square is light or dark.
    #' @param square A square such as `"e4"`.
    square_color = function(square){
      assertthat::assert_that(is_chess_square(square))
      strg <- sprintf("chess.square_color('%s')", square)
      private$ct$get(V8::JS(strg))
    },
    #' @description Return the active color, `"w"` or `"b"`.
    turn = function(){
      private$ct$get(V8::JS("chess.turn()"))
    },
    #' @description Undo and return the last move.
    undo = function(){
      private$ct$get(V8::JS("chess.undo()"))
    },
    #' @description Add a key-value pair to the PGN header.
    #' @param key A PGN header name.
    #' @param value A value coercible to character.
    header = function(key, value){
      private$ct$assign("key", key)
      private$ct$assign("value", as.character(value))
      private$ct$eval("chess.header(key, value)")
      invisible(self)
    },
    #' @description Return the PGN header as a list.
    get_header = function(){
      private$ct$get("chess.header()")
    },
    #### internals
    #' @description Return piece-by-piece move history as a tibble.
    history_detail = function(){
      resp <- .history_detail(self$history(verbose = TRUE))
      resp
    },
    #### generic methods
    #' @description Print a summary of the game.
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
    #' @description Render the current position.
    #' @param type Either `"chessboardjs"` or `"ggplot"`.
    #' @param ... Additional arguments passed to the renderer.
    plot    = function(type = "chessboardjs", ...){
      stopifnot(type %in% c("chessboardjs", "ggplot"))
      if (type == "ggplot") e <- ggchessboard(self$fen(), ...)
      if (type == "chessboardjs") e <- chessboardjs(self$fen(), ...)
      e
    },
    #' @description Print the game summary.
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

#' @importFrom stringr str_detect
.add_castlings_rows_to_history <- function(dfhist) {

  if (any(str_detect(dfhist[["san"]], "O-O"))) {

    # check if there is castlings for white
    white_castling <- dfhist |>
      dplyr::filter(.data$color == "w", stringr::str_detect(.data$san, "O-O"))

    if (nrow(white_castling) == 1) {
      row <- white_castling[["number_move"]]

      san_aux <- dfhist[["san"]][row]
      flag_aux <- dfhist[["flags"]][row]
      from_aux <- ifelse(str_detect(san_aux, "O-O-O"), "a1", "h1")
      to_aux <- ifelse(str_detect(san_aux, "O-O-O"), "d1", "f1")

      dfhist <- dplyr::bind_rows(
        dfhist[1:row, ],
        tibble::tibble(color = "w", from = from_aux, to = to_aux, flags = flag_aux,
                       piece = "r", san = san_aux, captured = NA, number_move = row),
        dfhist[(row + 1):nrow(dfhist), ])
    }

    # check if there is castling for black
    black_castling <- dfhist |>
      dplyr::filter(.data$color == "b", stringr::str_detect(.data$san, "O-O"))

    if (nrow(black_castling) == 1) {
      row <- black_castling[["number_move"]]

      san_aux <- dfhist[["san"]][row]
      flag_aux <- dfhist[["flags"]][row]
      from_aux <- ifelse(str_detect(san_aux, "O-O-O"), "a8", "h8")
      to_aux <- ifelse(str_detect(san_aux, "O-O-O"), "d8", "f8")

      dfhist <- dplyr::bind_rows(
        dfhist[1:row, ],
        tibble::tibble(color = "b", from = from_aux, to = to_aux, flags = flag_aux,
                       piece = "r", san = san_aux, captured = NA, number_move = row),
        dfhist[(row + 1):nrow(dfhist), ])

    }
  }

  tibble::as_tibble(dfhist)
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

  df_start_positions <- tibble::tibble("start_position" = start_positions)

  names(start_positions) <- start_positions

  paths <- lapply(start_positions, function(start_position, dfhist) {
    # start_position <- "g1"
    pos_current <- start_position
    pos_nummove <- 0
    piece_was_captured <- FALSE
    game_is_over <- FALSE

    df_path <- NULL

    while (!piece_was_captured & !game_is_over) {

      dfhist_aux <- dfhist |>
        dplyr::filter(
          .data$from == pos_current | .data$to == pos_current,
          .data$number_move > pos_nummove
        ) |>
        utils::head(1)

      # game is over?
      if (nrow(dfhist_aux) == 0) {
        game_is_over <- TRUE

        if (is.null(nrow(df_path))) {
          df_path <- tibble::tibble(from = pos_current, status = "game over")
        } else {
          df_path <- df_path |>
            dplyr::mutate(status = c(rep(NA, nrow(df_path) - 1), "game over"))
        }

        break
      }

      # pieces was captured
      if (dfhist_aux$to == pos_current) {
        piece_was_captured <- TRUE

        if (is.null(nrow(df_path))) {
          df_path <- tibble::tibble(from = pos_current,
                                    status = "captured",
                                    number_move_capture = dfhist_aux$number_move)
        } else {
          df_path <- df_path |>
            dplyr::mutate(
              status = c(rep(NA, nrow(df_path) - 1), "captured"),
              number_move_capture = c(rep(NA, nrow(df_path) - 1), dfhist_aux$number_move)
            )
        }

        break
      }

      df_path <- rbind(df_path,
                       tibble::tibble(from = pos_current,
                                      to = dfhist_aux$to,
                                      number_move = dfhist_aux$number_move))

      pos_current <- dfhist_aux$to
      pos_nummove <- dfhist_aux$number_move

    }

    df_path

  }, dfhist = dfhist)

  df_paths <- dplyr::bind_rows(paths, .id = "start_position")

  # calculating moves per pieces
  df_paths <- df_paths |>
    dplyr::group_by(.data$start_position) |>
    dplyr::mutate(piece_number_move = dplyr::row_number()) |>
    dplyr::ungroup() |>
    dplyr::arrange(.data$start_position)

  df_paths <- dplyr::full_join(
    .chesspiecedata() |>
      dplyr::select(piece = "name", "start_position"),
    df_paths,
    by = "start_position"
  )

  if (!"number_move_capture" %in% names(df_paths)) df_paths[["number_move_capture"]] <- NA

  df_paths <- cbind(df_paths |>
                      dplyr::select(-dplyr::all_of(c("start_position", "status", "number_move_capture"))),
                    df_paths |>
                      dplyr::select(dplyr::all_of(c("status", "number_move_capture"))))

  df_paths <- tibble::as_tibble(df_paths)

  # adding the pieces was capture the others
  df_capture <- df_paths |>
    dplyr::filter(.data$number_move %in% stats::na.omit(df_paths$number_move_capture)) |>
    dplyr::select(captured_by = "piece", number_move_capture = "number_move")

  df_paths <- df_paths |>
    dplyr::left_join(df_capture, by = "number_move_capture")

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
