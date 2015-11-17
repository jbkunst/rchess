library("rchess")



#### Header & Get header ####
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




