is_valid_fen <- function(x) {
  assertthat::is.string(x)
  ct <- .get_context_chess_from_fen()
  ct$assign("fen", x)
  val <- ct$get("chess.validate_fen(fen)")
  if (!val$valid) message(val$error)
  val$valid
}

assertthat::on_failure(is_valid_fen) <- function(call, env) {
  x <- call$x
  ct <- .get_context_chess_from_fen()
  ct$assign("fen", x)
  val <- ct$get("chess.validate_fen(fen)")
  paste0(x, " ",val$error)
}

is_valid_move <- function(x, mvs){
  x %in% mvs
}

assertthat::on_failure(is_valid_move) <- function(call, env) {
  x <- call$x
  paste0(x, " is not a posible move")
}

is_chess_square <- function(x){
  squares <- expand.grid(letters[seq(8)], seq(8))
  squares <- paste0(squares$Var1, squares$Var2)
  x %in% squares
}

assertthat::on_failure(is_chess_square) <- function(call, env) {
  paste0(deparse(call$x), " is not a valid chess square")
}