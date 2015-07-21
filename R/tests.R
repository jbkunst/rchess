# library("plyr")
# library("dplyr")
#
# fen1 <- "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
# fen2 <- "rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR w KQkq - 0 2"
# fen3 <- "rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2"
# fens <- c(fen1, fen2, fen3)
#
# dfens <- data_frame(id = seq(length(fens)), fen = fens)
#
# dchessm <- ldply(dfens$id, function(id){
#   chessboarddata(fen = dfens[[id, "fen"]]) %>% mutate(fen = id)
# })
#
# ggplot(dchessm) +
#   geom_tile(aes(col, row, fill = cc)) +
#   scale_fill_manual(values = cellcols) +
#   coord_equal() +
#   theme_null() +
#   geom_text(aes(col, row, label = text), size = 10) +
#   facet_wrap(~fen)
#
# chessboard(fen1)
