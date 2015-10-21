library("shiny")
library("rchess")

ui = shinyUI(fluidPage(
  chessboardjsOutput('board', width = 300),
  chessboardjsOutput('board2', width = 300)
))

server = function(input, output) {
  output$board <- renderChessboardjs({
    chessboardjs("rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2")
  })

  output$board2 <- renderChessboardjs({
    chessboardjs()
  })
}

shinyApp(ui = ui, server = server)
