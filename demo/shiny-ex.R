library("shiny")
library("rchess")

ui <- fluidPage(
  textInput("move", "Move", placeholder = "e4"),
  actionButton("make_move", "Move"),
  chessboardjsOutput("board", width = 300, height = "300px"),
  verbatimTextOutput("status")
)

server <- function(input, output, session) {
  game <- Chess$new()
  current_fen <- reactiveVal(game$fen())
  current_history <- reactiveVal(game$history())

  observeEvent(input$make_move, {
    req(nzchar(input$move))

    if (!input$move %in% game$moves()) {
      showNotification("Invalid move", type = "error")
      return()
    }

    game$move(input$move)
    current_fen(game$fen())
    current_history(game$history())
    updateTextInput(session, "move", value = "")
  })

  output$board <- renderChessboardjs({
    chessboardjs(current_fen(), width = 300, height = 300)
  })

  output$status <- renderPrint({
    history <- current_history()
    list(
      turn = game$turn(),
      history = history
    )
  })
}

shinyApp(ui = ui, server = server)
