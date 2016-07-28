library("rchess")

#### ISSUE #4 ####
pgn <- "1. e4 d6 2. d4 Nf6 3. Nc3 Nbd7 4. f4 e5 5. fxe5 dxe5
6. dxe5 Nxe5 7. Qxd8+ Kxd8 8. Bg5 Be7 9. O-O-O+ Ned7
10. Nf3 a6 11. e5 Ng4 12. Bxe7+ Kxe7 13. Nd5+ Kd8 14. Rd2 c6
15. Nb6 Rb8 16. Bc4 Ke7 17. Nxd7 Bxd7 18. Bxf7 Kxf7
19. Rxd7+ Kf8 20. Rhd1 Re8 21. Rxb7 Nxe5 22. Nxe5 Rxe5
23. Rd8+ Re8 24. Rdd7 Rg8 25. Rf7# 1-0"

chss <- Chess$new()
chss$load_pgn(pgn)
plot(chss)
dfhist <- chss$history(verbose = TRUE)
chss$history_detail()

plot(chss)

#### ISSUE #3 ####
pgn <- "1. e4 e5"
chss <- Chess$new()
chss$load_pgn(pgn)
dfhist <- chss$history(verbose = TRUE)
chss$history_detail() %>% View()

#### ISSUE #2 Header & Get header ####
pgn <- "1. e4 e5"
chss <- Chess$new()
chss$load_pgn(pgn)
chss$ascii()
chss$header("White", "Me")
chss$header("WhiteElo", 1800)
chss$header("Black", "You")
chss$header("Date", Sys.Date())
chss$header("Site", "This R session")
chss$header("Event", "Testing")
chss$header("Whatever", "Something")
chss$get_header()
cat(chss$pgn())

