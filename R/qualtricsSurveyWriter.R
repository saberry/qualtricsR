#' Creates an Advanced Format text file from csv.
#' 
#' @aliases qualtricsSurveyWriter
#' @author Seth Berry
#' @description This function creates an Advanced Format text file for import into Qualtrics.
#' @usage qualtricsSurveyWriter(completeSurveyDataFrame, roSeparator, pageBreakEvery,
#'                           outputFileName)
#' @param completeSurveyDataFrame The complete data frame containing the survey. 
#' Can be created as a data frame or read in from a file. Should contain 
#' variables called "question" (contains the question text), "responseOptions" (
#' contains the response option for each question, separated by some delimiter), 
#' and optionally "id" (the ID used in Qualtrics).
#' @param roSeparator Character (default: ";") The character used for separating
#' the response options.
#' @param pageBreakEvery (default: 0) How many questions on a page before 
#' inserting a page break.
#' @param outputFileName (default: "surveyOut.txt") the name and location for
#' the outputted text file.   
#' @details You can create the data frame or read in the survey from csv/xlsx.
#' @return This function returns a text file formatted for Qualtrics.
#' @examples
#' \dontrun{
#' questions = data.frame(question = c("I enjoy coding.",
#'                                     "To what extent do you hate or love R?", "Done?"),
#'                        responseOptions = c("No;Yes", 
#'                                            "Strongly hate;Hate;Neither;Love;Strongly love", 
#'                                            "No;Maybe;Yes"),
#'                        id = c("enjoyCode", "hateLoveR", "done"), 
#'                        stringsAsFactors = FALSE)
#' 
#' 
#' qualtricsSurveyWriter(completeSurveyDataFrame = questions, roSeparator = ";", 
#'              pageBreakEvery = 2)
#' }
#' @importFrom dplyr arrange
#' @importFrom reshape2 melt
#' @importFrom data.table fread
#' @export

qualtricsSurveyWriter <- function(completeSurveyDataFrame,  
                         roSeparator = ";", pageBreakEvery = 0, outputFileName = "surveyOut.txt") {
  
  rowID <- NULL
  
  variable <- NULL
  
  if(!(is.null(completeSurveyDataFrame$id))) {
    completeSurveyDataFrame$id <- paste("[[ID:", 
                                        completeSurveyDataFrame$id, 
                                        "]]", sep = "")
  } else {
    completeSurveyDataFrame$id <- paste("[[ID:", 
                                        gsub("\\s", "_", completeSurveyDataFrame$id), "]]", 
                                        sep = "")
  }
  
  if(pageBreakEvery != 0) {
    
    rowCount <- nrow(completeSurveyDataFrame)
    
    completeSurveyDataFrame$rowID <- 1:rowCount
    
    breakNumbers <- seq(from = pageBreakEvery, to = rowCount, 
                        by = pageBreakEvery) + .1
    
    completeSurveyDataFrame[(rowCount + 1):(rowCount + length(breakNumbers)), ] <- ""
    
    completeSurveyDataFrame$question[(rowCount + 1):(rowCount + length(breakNumbers))] <- "[[PageBreak]]\n"
    
    completeSurveyDataFrame$rowID[(rowCount + 1):(rowCount + length(breakNumbers))] <- breakNumbers
    
    completeSurveyDataFrame <- completeSurveyDataFrame[order(completeSurveyDataFrame$rowID), ]
    
  } else completeSurveyDataFrame$rowID = 1:nrow(completeSurveyDataFrame)
  
  meltedSurvey <- melt(completeSurveyDataFrame, id.vars = "rowID", factorsAsStrings = TRUE)
  
  meltedSurvey <- arrange(meltedSurvey, rowID, as.character(variable))
  
  meltedSurvey$value[which(meltedSurvey$variable == "id" & meltedSurvey$value != "")] <- 
    paste("[[Question:MC]]", "\n", 
          meltedSurvey$value[which(meltedSurvey$variable == "id" & meltedSurvey$value != "")],
          sep = "")
  
  meltedSurvey$value[which(meltedSurvey$variable == "responseOptions" & meltedSurvey$value != "")] <- 
    paste("[[Choices]]", "\n", 
          meltedSurvey$value[which(meltedSurvey$variable == "responseOptions" & meltedSurvey$value != "")],
          "\n",
          sep = "")
  
  meltedSurvey <- unlist(strsplit(meltedSurvey$value, roSeparator))
  
  meltedSurvey[1] <- paste("[[AdvancedFormat]]\n", meltedSurvey[1], sep = "\n")
  
  writeLines(meltedSurvey, outputFileName)
}
