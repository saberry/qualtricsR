#' Insert a text entry question
#' 
#' @author 
#' Seth Berry
#' @description 
#' This function inserts a text entry question ([[Question:TE]])
#' for Advanced Format text files.
#' @details 
#' This function works best as an addin for RStudio (v0.99.878 or newer).
#' @examples
#' \donttest{
#' insertTextEntry()
#' }
#' @import rstudioapi
#' @export
insertTextEntry = function() {
  if (rstudioapi::isAvailable() == FALSE) {
    stop("You must have RStudio v0.99.878 or newer.", 
         call. = FALSE)
  }
  rstudioapi::insertText("[[Question:TE]]\n[[ID: ]]")
}