#' Chess Class
#'
#' Chees class.
#'
#'
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
      private$ct$get("chess.pgn()")
    },
    get = function(square){
      assertthat::assert_that(is_chess_square(square))
      strg <- sprintf("chess.get('%s')", square)
      private$ct$get(V8::JS(strg))
    },
    history = function(verbose = FALSE){
      private$ct$assign("verb", verbose)
      private$ct$get("chess.history({ verbose: verb})")
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
      # Only function return invisible(self) to concatenate moves
      invisible(self)
    },
    moves = function(verbose = FALSE){
      private$ct$assign("verb", verbose)
      private$ct$get("chess.moves({ verbose: verb})")
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
      stopifnot(color %in% c("w", "b"))
      stopifnot(type %in% c("k", "q", "p", "n", "r", "b"))
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
      stopifnot(key %in% c("White", "Black", "Date", "Site", "Event", "Round", "Result"))
      private$ct$assign("key", key)
      private$ct$assign("value", value)
      private$ct$eval("chess.header(key, value)")
      invisible(self)
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

