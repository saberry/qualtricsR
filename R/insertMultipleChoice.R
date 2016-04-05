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
#' insertMultipleChoice()
#' @export
insertMultipleChoice= function() {
  rstudioapi::insertText("[[Question:MC]]\n[[ID: ]]\n\n[[Choices]]")
}