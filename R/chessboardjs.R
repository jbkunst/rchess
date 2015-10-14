#' Plot a chessboard via chessboardjs
#' @description Function to show the fen string in a chessboard widget.
#' @param fen Fen notation of a chessboard
#' @param width Width in pixels
#' @param height Height in pixels
#' @return The chessboardjs board
#' @examples
#'
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
#' @example
#'
#' \donttest{
#'
#' library(shiny)
#' library(rchess)
#'
#' ui = shinyUI(fluidPage(
#'   chessboardjsOutput('board', width = 300),
#'   chessboardjsOutput('board2', width = 300)
#' ))
#'
#' server = function(input, output) {
#'   output$board <- renderChessboardjs({
#'     chessboardjs("rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2")
#'   })
#'
#'   output$board2 <- renderChessboardjs({
#'     chessboardjs()
#'   })
#' }
#'
#' shinyApp(ui = ui, server = server)
#'
#' }
#'
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





