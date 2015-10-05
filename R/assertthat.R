is_chess_square <- function(x){
  squares <- expand.grid(letters[seq(8)], seq(8))
  squares <- paste0(squares$Var1, squares$Var2)
  x %in% squares
}

assertthat::on_failure(is_chess_square) <- function(call, env) {
  paste0(deparse(call$x), " is not a valid chess square")
}

# assert_that(is_chess_square('a5'))
# assert_that(is_chess_square('s5'))