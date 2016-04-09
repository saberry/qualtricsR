#' Insert a page break
#' 
#' @author 
#' Seth Berry
#' @description 
#' This function inserts a page break question ([[PageBreak]])
#' for Advanced Format text files.
#' @details 
#' This function works best as an addin for RStudio (v0.99.878 or newer).
#' @examples
#' insertPageBreak()
#' @importFrom rstudioapi insertText
#' @export
insertPageBreak = function() {
  insertText("[[PageBreak]]")
}