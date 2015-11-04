#' Chess openings data
#'
#' This data comes from the chess Chess Opening Theory wikibook \url{https://en.wikibooks.org/wiki/Chess_Opening_Theory}.
#' The oppening were parse using \code{rvest} package.
#' @section Links:
#'
#' \itemize{
#'
#'  \item https://en.wikibooks.org/wiki/Chess_Opening_Theory/ECO_volume_A
#'  \item https://en.wikibooks.org/wiki/Chess_Opening_Theory/ECO_volume_B
#'  \item https://en.wikibooks.org/wiki/Chess_Opening_Theory/ECO_volume_C
#'  \item https://en.wikibooks.org/wiki/Chess_Opening_Theory/ECO_volume_D
#'  \item https://en.wikibooks.org/wiki/Chess_Opening_Theory/ECO_volume_E
#'
#' }
#'
#' @section Variables:
#'
#' \itemize{
#'
#'  \item \code{eco}: The game's opening classification
#'  \item \code{name}: Games's location
#'  \item \code{pgn}: The game's pgn
#'
#' }
#'
#' @docType data
#' @name chessopenings
#' @usage chessopenings
#' @format A \code{data frame} with 544 observations and 3 variables.
#' @examples
#' data(chessopenings)
#' library("dplyr")
#' head(chessopenings)
NULL