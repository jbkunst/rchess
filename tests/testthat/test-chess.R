starting_fen <- "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"

test_that("Chess initializes the standard position", {
  game <- Chess$new()

  expect_equal(game$fen(), starting_fen)
  expect_equal(game$turn(), "w")
  expect_length(game$history(), 0)
  expect_true("e4" %in% game$moves())
})

test_that("moves update history, turn, and board state", {
  game <- Chess$new()

  expect_invisible(game$move("e4"))
  expect_equal(game$turn(), "b")
  expect_equal(game$history(), "e4")
  expect_false(identical(game$fen(), starting_fen))

  game$undo()
  expect_equal(game$fen(), starting_fen)
  expect_equal(game$turn(), "w")
})

test_that("invalid FEN strings are rejected", {
  expect_error(Chess$new("not-a-fen"))
})
