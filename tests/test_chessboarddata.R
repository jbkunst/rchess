library(rchess)
chs <- Chess$new()
moves <- 25


library("magrittr")
library("dplyr")
library("ggplot2")

data <- rchess:::.chessboarddata() %>% mutate(move = 0)

for (m in seq(moves)){
  mvs <- chs$moves()
  mv <- sample(mvs, size = 1)

  daux <- chs$move(mv)$fen() %>%
    rchess:::.chessboarddata() %>%
    mutate(move = m)

  data <- rbind(data, daux)

}

ggplot(data, aes(x, y)) +
  geom_tile(aes(fill = cc)) + scale_fill_manual(values = c("#D2B48C", "#F5F5DC")) +
  geom_text(aes(label = text)) +
  coord_equal() +
  facet_wrap(~move) +
  rchess:::theme_null()