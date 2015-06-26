#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
chessboard <- function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
                       width = NULL, height = NULL) {

  # forward options using x
  x = list(
    fen = fen
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'chessboard',
    x,
    width = width,
    height = height,
    package = 'rchess'
  )
}

#' Widget output function for use in Shiny
#'
#' @export
chessboardOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'chessboard', width, height, package = 'rchess')
}

#' Widget render function for use in Shiny
#'
#' @export
renderChessboard <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, chessboardOutput, env, quoted = TRUE)
}
