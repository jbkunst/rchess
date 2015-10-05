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
      self$init_ct(fen)
    },
    init_ct = function(fen){
      private$ct <- .get_context_chess_from_fen(fen)
    },
    # chessjs api
    ascii = function(){
      cat(private$ct$get("chess.ascii()"))
    },
    clear = function(){
      private$ct$eval(V8::JS("chess.clear()"))
      invisible(self)
    },
    fen = function(){
      private$ct$get(V8::JS("chess.fen()"))
    },
    game_over = function(){
      private$ct$get(V8::JS("chess.game_over()"))
    },
    get = function(square){},
    history = function(options){},
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
    header = function(){},
    insufficient_material = function(){
      private$ct$get(V8::JS("chess.insufficient_material()"))
    },
    load = function(fen){},
    load_pgn = function(pgn, options){},
    move = function(move){
      strg <- sprintf("chess.move('%s')", move)
      private$ct$eval(V8::JS(strg))
      invisible(self)
    },
    moves = function(options){
      moves <- private$ct$get("chess.moves()")
      moves
    },
    pgn = function(options){},
    put = function(piece, square){},
    remove = function(square){},
    reset = function(){},
    square_color = function(square){},
    turn = function(){},
    undo = function(){},
    validate_fen = function(fen){},

    # generic methods
    summary = function(){ cat("summary Chess object")},
    plot    = function(){ cat("plot Chess object")},
    print   = function(){ cat("print Chess object") }))


.get_context_chess_from_fen <- function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1") {
  ct <- V8::new_context();
  ct$source(system.file("htmlwidgets/lib/chess.min.js", package = "rchess"))
  ct$assign("fen", fen)
  ct$assign("chess", V8::JS("new Chess(fen);"))
  ct
}


summary.Chess <- function(x, ...) {
  x$summary()
}

plot.Chess <- function(x, ...) {
  x$plot()
}

print.Chess <- function(x, ...) {
  x$print()
}

