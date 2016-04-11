#' Insert a multiple choice question
#' 
#' @author 
#' Seth Berry
#' @description 
#' This function inserts a multiple choice question ([[Question:MC]])
#' for Advanced Format text files.
#' @details 
#' This function works best as an addin for RStudio (v0.99.878 or newer).
#' @examples
#' \dontrun{
#' insertMultipleChoice()
#' }
#' @import rstudioapi
#' @export
insertMultipleChoice= function() {
  if (rstudioapi::isAvailable() == FALSE) {
    stop("You must have RStudio v0.99.878 or newer.", 
         call. = FALSE)
  }
  rstudioapi::insertText("[[Question:MC]]\n[[ID: ]]\n\n[[Choices]]")
}