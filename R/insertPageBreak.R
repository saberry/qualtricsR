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
#' \donttest{
#' insertPageBreak()
#' }
#' @import rstudioapi
#' @export
insertPageBreak = function() {
  if (rstudioapi::isAvailable() == FALSE) {
    stop("You must have RStudio v0.99.878 or newer.", 
         call. = FALSE)
  }
  rstudioapi::insertText("[[PageBreak]]")
}