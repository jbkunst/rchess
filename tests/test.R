library(rchess)
rm(list = ls())

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


### Other example
chss2 <- Chess$new("rnb1kbnr/pppp1ppp/8/4p3/5PPq/8/PPPPP2P/RNBQKBNR w KQkq - 1 3")

chss2$ascii()

chss2$in_check()

chss2$in_checkmate()


### Slatemate
chss3 <- Chess$new("4k3/4P3/4K3/8/8/8/8/8 b - - 0 78")

chss3$in_stalemate()

#### Methods ####
summary(chss)

plot(chss)

print(chss)


