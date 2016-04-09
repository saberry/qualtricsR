#' Insert a matrix question
#' 
#' @author 
#' Seth Berry
#' @description 
#' This function inserts a matrix question ([[Question:Matrix]])
#' for Advanced Format text files.
#' @details 
#' This function works best as an addin for RStudio (v0.99.878 or newer).
#' @examples
#' insertMatrix()
#' @importFrom rstudioapi insertText
#' @export
insertMatrix = function() {
  insertText("[[Question:Matrix]]\n[[ID: ]]\n\n[[Choices]]\n\n[[Answers]]")
}