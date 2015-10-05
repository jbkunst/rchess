library(rchess)
rm(list = ls())

### INTERNAL ###
ct <- rchess:::.get_context_chess_from_fen()
ct$get(V8::JS("chess.get('a2')"))

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
chss$get("z5")


#### Methods ####
summary(chss)

plot(chss)

print(chss)


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




