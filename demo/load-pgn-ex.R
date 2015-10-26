pgn <- system.file("extdata/pgn/kasparov_vs_topalov.pgn", package = "rchess")
pgn <- readLines(pgn, warn = FALSE)
pgn <- paste(pgn, collapse = "\n")
cat(pgn)

chsspgn <- Chess$new()

chsspgn$load_pgn(pgn)

chsspgn$history_detail()

chsspgn$history_detail() %>% filter(!is.na(status))
