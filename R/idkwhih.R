library("V8")

ct <- new_context();
ct$source("https://raw.githubusercontent.com/jhlywa/chess.js/master/chess.js")

ct$assign("chess", JS("new Chess();"))

ct$get("chess")


ct$get("chess.moves()")

moves = chess.moves();

while(!ct$get("chess.game_over()")) {
  
  ct$assign("moves", JS("chess.moves()"))
  ct$get("moves")
  
  ct$assign("move", JS("moves[Math.floor(Math.random() * moves.length)];"))
  ct$get("move")
  
  ct$eval(JS("chess.move(move);"))
  
  pgn <- ct$eval("chess.pgn();")
  
  # print(pgn)
  
  ass <- ct$eval("chess.ascii();")
  print(cat(ass))

}

ct$eval("chess.fen();")


