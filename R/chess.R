#' Chess Class
#'
#' Chees class.
#'
#'
#' @export
Chess <- R6::R6Class(
  "Chess",
  public = list(
    fen = NA,
    initialize = function(fen) {
      self$fen <- "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
    },
    ascii = function(){
      .print_chess(self$fen)
    },
    moves = function(){
      .get_moves(self$fen)
    },
    print = function(){
      .print_chess(self$fen)
    }))


.get_context_chess_from_fen <- function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1") {
  ct <- V8::new_context();
  ct$source(system.file("htmlwidgets/lib/chess.min.js", package = "rchess"))
  ct$assign("fen", fen)
  ct$assign("chess", V8::JS("new Chess(fen);"))

  ct
}

.print_chess <- function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1") {

  ct <- .get_context_chess_from_fen(fen)
  cat(ct$get("chess.ascii()"))
  invisible()

}

.get_moves <- function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1") {

  ct <- .get_context_chess_from_fen(fen)
  moves <- ct$get("chess.moves()")
  moves

}


