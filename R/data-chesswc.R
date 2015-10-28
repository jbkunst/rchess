#' FIDE World Cups data
#'
#' This data comes from the \url{http://www.theweekinchess.com/} site and
#' represent 1,266 games in the FIDE World Cupo 11, 13 & 15.  The data
#' has been parsed from the downloaded pgn files using \url{https://github.com/jbkunst/chess-db}
#' scripts.
#'
#' @section Links:
#'
#' \itemize{
#'
#'  \item http://www.theweekinchess.com/chessnews/events/fide-world-cup-2015
#'  \item http://www.theweekinchess.com/chessnews/events/fide-world-cup-tromso-2013
#'  \item http://www.theweekinchess.com/chessnews/events/fide-world-cup-khanty-mansiysk-2011
#'
#' }
#'
#' @section Variables:
#'
#' \itemize{
#'
#'  \item \code{event}: Games's event
#'  \item \code{site}: Games's location
#'  \item \code{date}: Game's date
#'  \item \code{round}: Games's round
#'  \item \code{white}: White player's name
#'  \item \code{black}: Black player's name
#'  \item \code{result}: Game's result
#'  \item \code{whiteelo}: White player's elo rating
#'  \item \code{blackelo}: Black player's elo rating
#'  \item \code{eco}: The game's opening classification
#'  \item \code{pgn}: The game's pgn
#'
#' }
#'
#' @docType data
#' @name chesswc
#' @usage chesswc
#' @format A \code{data frame} with 1,266 observations and 11 variables.
#' @examples
#' data(chesswc)
#' library("dplyr")
#' count(chesswc, event)
NULL