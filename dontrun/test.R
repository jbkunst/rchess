#' ---
#' title: "Presenting `rchess` package"
#' author: "Joshua Kunst"
#' output:
#'  html_document:
#'    toc: true
#'    keep_md: yes
#' ---

library("rchess")
rm(list = ls())

#' ## Basic Usage
chss <- Chess$new()

chss

chss$moves()

chss$moves(verbose = TRUE)

chss$move("a3")

#' We can concate some moves and a capture
chss$move("e5")$move("f4")$move("Qe7")$move("fxe5")

plot(chss)

chss$turn()

chss$square_color("h1")

chss$get("e5")

chss$history(verbose = TRUE)

chss$history()

chss$undo()

chss$history()

chss$fen()

chss$header("White", "You")

chss$header("Black", "Me")

cat(chss$pgn())

chss$ascii()

#' ## Generic Methods
#'
#' ### Summary
summary(chss)

#' ### Plot
#'
#' Via `chessboardjs` htmlwidget implementation
plot(chss)

#' If you dont like so much `chessboarjs` you can do vía ggplot2 with the `ggchessboard` function.
plot(chss, type = "ggplot")
plot(chss, type = "ggplot", cellcols = c("#CCCCCC", "#FAFAFA"), piecesize = 13, perspective = "black")

#' If you don't have a Chess object but a fen string you can do:
fen <- "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2"

chessboardjs(fen)

ggchessboard(fen)

#' ### Print
#'
#' Sames as summary (by now)
print(chss)


#' ## Other Functions
#'
#' ### Load Fen
chss2 <- Chess$new()

chss2$plot()

fen <- "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2"

chss2$load(fen)

chss2$plot()

#' ### Load PGN
pgn <- system.file("extdata/kasparov_vs_topalov.pgn", package = "rchess")
pgn <- readLines(pgn, warn = FALSE)
pgn <- paste(pgn, collapse = "\n")
cat(pgn)

chsspgn <- Chess$new()

chsspgn$load_pgn(pgn)

cat(chsspgn$pgn())

chsspgn$history()

chsspgn$history(verbose = TRUE)


#' ### State validation
chss2 <- Chess$new("rnb1kbnr/pppp1ppp/8/4p3/5PPq/8/PPPPP2P/RNBQKBNR w KQkq - 1 3")

plot(chss2)

chss2$in_check()

chss2$in_checkmate()

#' ### Slatemate validation
chss3 <- Chess$new("4k3/4P3/4K3/8/8/8/8/8 b - - 0 78")

plot(chss3)

chss3$in_stalemate()

#' ### 3 fold repetition
chss4 <- Chess$new("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")

chss4$in_threefold_repetition()

chss4$move('Nf3')$move('Nf6')$move('Ng1')$move('Ng8')
chss4$in_threefold_repetition()

chss4$move('Nf3')$move('Nf6')$move('Ng1')$move('Ng8')
chss4$in_threefold_repetition()

chss4$history()

#' ### Insufficient material
chess5 <- Chess$new("k7/8/n7/8/8/8/8/7K b - - 0 1")
plot(chess5)
chess5$insufficient_material()



### INTERNAL ###
# ct <- rchess:::.get_context_chess_from_fen()
# ct$get(V8::JS("chess.get('a2')"))
# ct$eval(V8::JS("chess.move('a3')"))
# ct$eval(V8::JS("chess.move('d5')"))
# ct$get(V8::JS("chess.get('a3')"))
# cat(ct$get(V8::JS("chess.ascii()")))
# ct$assign("verb", TRUE)
# ct$get("chess.history({ verbose: verb})")
# ct$assign("fen", "no fen")
# ct$get("chess.validate_fen(fen)")
