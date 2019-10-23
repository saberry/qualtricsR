#' Creates an Advanced Format text file from csv.
#' 
#' @aliases createAdvancedFormat
#' @author Seth Berry
#' @description This function creates a text file for import into Qualtrics.
#' @usage surveyWriter(completeSurveyDataFrame, roSeparator, pageBreakEvery,
#'                           outputFileName)
#' @param completeSurveyDataFrame The complete data frame containing the survey. 
#' Can be created as a data frame or read in from a file. Should contain 
#' variables called "question" (contains the question text), "responseOptions" (
#' contains the response option for each question, separated by some delimiter), 
#' and optionally "questionID" (the ID used in Qualtrics).
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
#'                        questionID = c("enjoyCode", "hateLoveR", "done"), 
#'                        stringsAsFactors = FALSE)
#' 
#' 
#' surveyWriter(completeSurveyDataFrame = questions, roSeparator = ";", 
#'              pageBreakEvery = 2)
#' }
#' @export

surveyWriter <- function(completeSurveyDataFrame,  
                         roSeparator = ";", pageBreakEvery = 0, outputFileName = "surveyOut.txt") {
  
  sink(outputFileName)
  
  if(pageBreakEvery != 0) {
    
    rowCount <- nrow(completeSurveyDataFrame)
    
    completeSurveyDataFrame$rowID <- 1:rowCount
    
    breakNumbers <- seq(from = pageBreakEvery, to = rowCount, 
                        by = pageBreakEvery) + .1
    
    completeSurveyDataFrame[(rowCount + 1):(rowCount + length(breakNumbers)), ] <- ""
    
    completeSurveyDataFrame$question[(rowCount + 1):(rowCount + length(breakNumbers))] <- "[[PageBreak]]"
    
    completeSurveyDataFrame$rowID[(rowCount + 1):(rowCount + length(breakNumbers))] <- breakNumbers
    
    completeSurveyDataFrame <- completeSurveyDataFrame[order(completeSurveyDataFrame$rowID), ]
  }
  
  numberQuestions <- nrow(completeSurveyDataFrame)
  
  question <- completeSurveyDataFrame$question
  
  if(!(is.null(completeSurveyDataFrame$questionID))) {
    questionID <- completeSurveyDataFrame$questionID
  }
  
  responseOptions <- completeSurveyDataFrame$responseOptions
  
  cat("[[AdvancedFormat]]")
  
  lapply(1:numberQuestions, function(x) {
    if(question[x] == "[[PageBreak]]") {
      cat(paste("\n", question[x], "\n", sep = "\n"))
    } else {
      
      if(!(is.null(questionID[x]))) {
        idField <- paste("[[ID:", questionID[x], "]]", sep = "")
      } else {
        idField <- paste("[[ID:", gsub("\\s", "_", question[x]), "]]", sep = "")
      }
      
      responseOptionsFormatted <- paste(unlist(strsplit(responseOptions[x], roSeparator)), collapse = "\n")
      
      questionWrite <- paste("\n", "[[Question:MC]]", 
                             idField,  
                             question[x],  
                             "[[Choices]]",  
                             responseOptionsFormatted, sep = "\n")
      
      cat(questionWrite)
    }
    
  })
  
  sink()
}
