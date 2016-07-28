library("plyr")
library("dplyr")
library("rvest")
library("stringr")
rm(list = ls())

urls <- paste0("https://en.wikibooks.org/wiki/Chess_Opening_Theory/ECO_volume_", LETTERS[1:5])

chessopenings <- ldply(urls, function(url){ # url <- sample(urls, size = 1)

  # url <- "https://en.wikibooks.org/wiki/Chess_Opening_Theory/ECO_volume_A"

  message(url)

  data <- read_html(url) %>%
    html_nodes("dd") %>%
    html_text()

  data <- data[str_detect(data, "^\\w{1}\\d{2}")]
  data <- data[!str_detect(data, "^\\w{1}00")]
  # data <- data[101]
  # data <- str_replace_all(data, ":", "")

  last_1. <- str_locate_all(data, ": 1\\.")
  last_1. <- llply(last_1., function(x){ # x <- last_1.[[2]]
    as.vector(x[nrow(x), 1])
  }) %>% unlist()

  eco <- str_extract(data, "^\\w{1}\\d{2}")
  variant <- str_sub(data, 5, last_1. - 1) %>% str_trim()
  pgn <- str_sub(data, last_1.) %>% str_replace_all(":", "") %>% str_trim()

  data_frame(eco, variant, pgn)

}) %>% tbl_df()


chessopenings <- chessopenings %>%
  mutate(variant = str_replace(variant, "Gr.*nfeld", "Grunfeld"),
         variant = str_replace(variant, "L.*wenthal", "Lowenthal"),
         variant = str_replace(variant, "G.*ring", "Goring"),
         variant = str_replace(variant, "M.*ller", "Moller"),
         variant = str_replace(variant, "S.*misch", "Samisch"),
         variant = str_replace(variant, "Velimirovi.* A", "Velimirovic A"),
         variant = str_replace(variant, "Â", ""))

chessopenings %>% filter(eco == "D85") %>% .$variant %>% .[1]
chessopenings %>% filter(eco == "B32") %>% .$variant %>% .[1]
chessopenings %>% filter(eco == "C44") %>% .$variant
chessopenings %>% filter(eco == "B89") %>% .$variant

#### Name opening
url <- "https://en.wikibooks.org/wiki/Chess_Opening_Theory"
openings <- read_html(url) %>%
  html_nodes("dd > a") %>%
  html_text()
openings <- openings[!str_detect(openings, "ECO volume")]
openings <- str_replace(openings, "Gr.*nfeld", "Grunfeld")

chessopenings <- chessopenings %>% mutate(name = "")

for (op in openings) {
  message(op)
  chessopenings <- chessopenings %>%
    mutate(name = ifelse(str_detect(variant, op), op, name))
}

chessopenings <- chessopenings %>%
  mutate(name = ifelse(str_detect(pgn, "1. d4 Nf6 2. c4 g6") & name == "", "King's Indian Defence", name))

chessopenings <- chessopenings %>%
  mutate(name = ifelse(str_detect(variant, "English") & str_detect(pgn, "1. c4") & name == "", "English", name))

chessopenings <- chessopenings %>%
  mutate(name = ifelse(str_detect(variant, "Semi-Slav") & name == "", "Queen's Gambit Declined", name))

chessopenings <- chessopenings %>%
  mutate(name = ifelse(str_detect(variant, "Modern Benoni") & name == "", "Benoni Defence", name))

chessopenings <- chessopenings %>%
  mutate(name = ifelse(str_detect(pgn, "1. e4 c5") & name == "", "Sicilian Defence", name))

chessopenings <- chessopenings %>%
  mutate(name = ifelse(str_detect(variant, "Nimzo-Indian") & name == "", "Nimzo-Indian Defence", name))

chessopenings <- chessopenings %>%
  mutate(name = ifelse(str_detect(pgn, "1. e4 e5 2. Nf3 Nc6 3. Bc4 Bc5") & name == "", "Giuoco Piano", name))

chessopenings <- chessopenings %>%
  mutate(name = ifelse(str_detect(pgn, "1. d4 d5 2. c4") & name == "", "Queen's Gambit Declined", name))

chessopenings <- chessopenings %>%
  mutate(name = ifelse(str_detect(pgn, "1. d4 Nf6 2. c4 c5 3. d5") & name == "", "Benoni Defence", name))

chessopenings <- chessopenings %>%
  mutate(name = ifelse(str_detect(pgn, "1. e4 e5 2. Nf3 Nc6 3. Bc4 Nf6") & name == "", "Two Knights' Defence", name))

chessopenings <- chessopenings %>%
  mutate(name = ifelse(str_detect(pgn, "1. d4 Nf6") & name == "", "Indian Defence", name))

chessopenings <- chessopenings %>%
  mutate(name = ifelse(name == "", "Irregular Opening", name))

#
chessopenings <- chessopenings %>% select(eco, name, variant, pgn)

save(chessopenings, file = "data/chessopenings.rda")
