#' Plot a chessboard via chessboardjs
#' @description Function to show the fen string in a chessboard widget.
#' @param fen Fen notation of a chessboard
#' @param width Width in pixels
#' @param height Height in pixels
#' @return The chessboardjs board
#' @examples
#'
#' chessboardjs()
#'
#' @import htmlwidgets
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
#' @param outputId Id of the div tag
#' @param width Width in pixels
#' @param height Height in pixels
#' @export
chessboardjsOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'chessboardjs', width, height, package = 'rchess')
}

#' Widget render function for use in Shiny
#' @param expr Expression
#' @param env Environment
#' @param quoted Quoted
#' @export
renderChessboardjs <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, chessboardjsOutput, env, quoted = TRUE)
}





