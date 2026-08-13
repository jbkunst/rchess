test_that("PGN compatibility", {
  game <- Chess
  expect_true(inherits(game, "R6ClassGenerator"))
})
