library(rchess)
rm(list = ls())

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

#### Creating Chess object ####
chss <- Chess$new()

class(chss)

chss$ascii()

chss$moves()

chss$move("a3")

chss$ascii()

chss$move("e5")$move("f4")

chss$ascii()

chss$fen()

chss$get("e5")

chss$history()

chss$history(verbose = TRUE)




#### Methods ####
summary(chss)

#' Via ggchessboard function
plot(chss)

#' Via ggchessboard function
plot(chss, cellcols = c("#CCCCCC", "#FAFAFA"), piecesize = 17, perspective = "black")

#' Via chessboardjs htmlwidget implmentation
plot(chss, type = "chessboardjs", width = 400, height = 400)

#' Or just ascii
plot(chss, type = "ascii")


print(chss)

### Example validation FEN ###
chsserror <- Chess$new(fen = "something is not fen")

chss$validate_fen("asda")

#### Example State validation #####
chss2 <- Chess$new("rnb1kbnr/pppp1ppp/8/4p3/5PPq/8/PPPPP2P/RNBQKBNR w KQkq - 1 3")

chss2$ascii()

chss2$in_check()

chss2$in_checkmate()


#### Example Slatemate #####
chss3 <- Chess$new("4k3/4P3/4K3/8/8/8/8/8 b - - 0 78")

chss3$in_stalemate()

#### Example 3 fold rep #####
chss4 <- Chess$new("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
chss4

chss4$in_threefold_repetition()

chss4$move('Nf3')$move('Nf6')$move('Ng1')$move('Ng8')
chss4$fen()
chss4$in_threefold_repetition()

chss4$move('Nf3')$move('Nf6')$move('Ng1')$move('Ng8')
chss4$fen()
chss4$in_threefold_repetition()

#### Example insu material
chess5 <- Chess$new("k7/8/n7/8/8/8/8/7K b - - 0 1")
chess5$insufficient_material()




