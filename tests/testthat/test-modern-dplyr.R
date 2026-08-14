test_that("verbose methods work after loading PGN", {
  game <- do.call(Chess[["new"]], list())
  do.call(game[["load_pgn"]], list("1. e4"))

  moves <- do.call(game[["moves"]], list(verbose = TRUE))
  history <- do.call(game[["history"]], list(verbose = TRUE))
  detail <- do.call(game[["history_detail"]], list())

  expect_true(tibble::is_tibble(moves))
  expect_true(tibble::is_tibble(history))
  expect_true(tibble::is_tibble(detail))

  expect_named(moves, c("color", "from", "to", "flags", "piece", "san"))
  expect_named(history, c("color", "from", "to", "flags", "piece", "san", "number_move"))
  expect_named(detail, c("piece", "from", "to", "number_move", "piece_number_move", "status", "number_move_capture", "captured_by"))
})

test_that("history detail handles castling", {
  game <- do.call(Chess[["new"]], list())
  do.call(game[["load_pgn"]], list("1. e4 e5 2. Nf3 Nc6 3. Bc4 Nf6 4. O-O"))

  detail <- do.call(game[["history_detail"]], list())

  expect_true(tibble::is_tibble(detail))
  expect_named(detail, c("piece", "from", "to", "number_move", "piece_number_move", "status", "number_move_capture", "captured_by"))
})

test_that("history detail uses modern tibble operations", {
  game <- Chess$new()
  game$move("e4")$move("d5")$move("exd5")

  detail <- game$history_detail()

  expect_s3_class(detail, "tbl_df")
  expect_true(any(!is.na(detail$captured_by)))
  expect_false(".id" %in% names(detail))
})
