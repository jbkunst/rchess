#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
chessboardjs <- function(fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
                       width = 300, height = 300) {

  # forward options using x
  x = list(
    fen = fen
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'chessboardjs',
    x,
    width = width,
    height = height,
    package = 'rchess'
  )
}

#' Widget output function for use in Shiny
#'
#' @export
chessboardjsOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'chessboardjs', width, height, package = 'rchess')
}

#' Widget render function for use in Shiny
#'
#' @export
renderChessboardjs <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, chessboardOutput, env, quoted = TRUE)
}
